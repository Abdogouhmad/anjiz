package com.freesoftware.anjiz.pomodoro

import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder

/**
 * Foreground service that owns the pomodoro clock and the Live Update
 * notification (Android 16+; inert on older devices).
 *
 * Phase ends are driven exclusively by [PomodoroAlarm] broadcasts — there is
 * no in-process ticker — so a phase-end alarm restores the persisted
 * [PomodoroState] and advances the run even after process death.
 */
class PomodoroService : Service() {

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val command = intent ?: return START_NOT_STICKY
        if (Build.VERSION.SDK_INT < 36) {
            // Inert below Android 16: satisfy the startForegroundService()
            // contract with a bare notification, then stop again.
            PomodoroForeground.promote(this, PomodoroForeground.buildIdleForContract(this))
            PomodoroForeground.stop(this)
            return START_NOT_STICKY
        }
        if (command.action == PomodoroContract.ACTION_START) {
            handleStart(command)
            return START_NOT_STICKY
        }
        // A phase-end alarm restarts a killed process via
        // startForegroundService(), so promote before dispatching; false means
        // there is no run left and the service already stopped itself.
        if (!PomodoroForeground.ensureForeground(this)) return START_NOT_STICKY
        when (command.action) {
            PomodoroContract.ACTION_PAUSE -> handlePause()
            PomodoroContract.ACTION_RESUME -> handleResume()
            PomodoroContract.ACTION_SKIP -> handleSkip()
            PomodoroContract.ACTION_PHASE_END -> handlePhaseEnd()
            PomodoroContract.ACTION_DONE -> handleDone()
            PomodoroContract.ACTION_STOP -> handleStop()
        }
        return START_NOT_STICKY
    }

    private fun handleStart(intent: Intent) {
        val state = PomodoroState.fromStartIntent(intent, nowMs())
        PomodoroState.save(this, state)
        PomodoroForeground.promote(this, PomodoroNotification.buildLive(this, state, nowMs()))
        PomodoroAlarm.schedule(this, state.phaseEndEpochMs)
        PomodoroChannelHandler.send("phaseChanged", state.toMap())
    }

    private fun handlePause() {
        val state = PomodoroState.load(this) ?: return
        if (state.paused) return
        val remaining = (state.phaseEndEpochMs - nowMs()).coerceAtLeast(0)
        PomodoroAlarm.cancel(this)
        commit(state.copy(phaseEndEpochMs = 0, paused = true, remainingMs = remaining), "paused")
    }

    private fun handleResume() {
        val state = PomodoroState.load(this) ?: return
        if (!state.paused) return
        val end = nowMs() + state.remainingMs
        PomodoroAlarm.schedule(this, end)
        commit(state.copy(phaseEndEpochMs = end, paused = false, remainingMs = 0), "resumed")
    }

    /** Skip ends the phase now and silently; the alarm path pings the user. */
    private fun handleSkip() = finishPhase(alert = false)

    private fun handlePhaseEnd() = finishPhase(alert = true)

    /**
     * Shared tail of skip/phase-end: advance the run, persist it, and either
     * start the next phase, hold it paused, or complete the whole run.
     */
    private fun finishPhase(alert: Boolean) {
        val state = PomodoroState.load(this) ?: return
        PomodoroAlarm.cancel(this)
        val next = PomodoroPhases.advance(state)
        if (alert) {
            PomodoroAlert.postPhaseEndAlert(
                this,
                state.title.ifBlank { TITLE_FALLBACK },
                PomodoroAlert.phaseEndBody(state, next),
            )
        }
        val entered = PomodoroRun.entered(next, nowMs())
        if (entered == null) {
            // Final focus ended: persist the all-done state and shut down.
            val complete = PomodoroRun.completed(state)
            PomodoroState.save(this, complete)
            PomodoroChannelHandler.send("completed", complete.toMap())
            PomodoroForeground.stop(this)
            return
        }
        if (entered.autoStartNext) PomodoroAlarm.schedule(this, entered.phaseEndEpochMs)
        commit(entered, "phaseChanged")
    }

    /** User-facing "Done": tell Dart with the taskId, then tear down. */
    private fun handleDone() {
        val state = PomodoroState.load(this)
        PomodoroAlarm.cancel(this)
        PomodoroState.save(this, null)
        if (state != null) {
            PomodoroChannelHandler.send("done", mapOf("taskId" to state.taskId))
        }
        PomodoroForeground.stop(this)
    }

    private fun handleStop() {
        PomodoroAlarm.cancel(this)
        PomodoroState.save(this, null)
        PomodoroForeground.stop(this)
    }

    /** Persist [state], refresh the live notification and notify Dart. */
    private fun commit(state: PomodoroState, event: String) {
        PomodoroState.save(this, state)
        PomodoroForeground.update(this, state, nowMs())
        PomodoroChannelHandler.send(event, state.toMap())
    }

    override fun onDestroy() {
        super.onDestroy()
        // Deliberately no alarm cancellation: the persisted state plus the
        // pending phase-end alarm are what keep the run alive across process
        // death. Explicit stop paths (stop/done/pause) cancel the alarm first.
    }

    companion object {
        private const val TITLE_FALLBACK = "Pomodoro"

        /** Intent factory shared by [PomodoroChannelHandler] and the receiver. */
        fun commandIntent(context: Context, action: String): Intent =
            Intent(context, PomodoroService::class.java).setAction(action)

        private fun nowMs(): Long = System.currentTimeMillis()
    }
}

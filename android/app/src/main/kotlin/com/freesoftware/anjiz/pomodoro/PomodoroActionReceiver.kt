package com.freesoftware.anjiz.pomodoro

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build

/**
 * Receives notification action taps and phase-end alarms, then forwards them
 * to [PomodoroService] as plain commands.
 *
 * Not a participant in the timer itself: the service restores the persisted
 * [PomodoroState], so a phase-end alarm still advances the run correctly when
 * the app process was killed in the meantime.
 */
class PomodoroActionReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        val action = intent.action ?: return
        if (action !in HANDLED_ACTIONS) return
        val serviceIntent = Intent(context, PomodoroService::class.java).setAction(action)
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(serviceIntent)
            } else {
                context.startService(serviceIntent)
            }
        } catch (_: IllegalStateException) {
            // Android 12+ background-start restriction. The pending intents
            // from our notification/almost always carry an exemption, so this
            // is belt-and-braces: degrade instead of crashing.
            tryStartService(context, serviceIntent)
        } catch (_: SecurityException) {
            tryStartService(context, serviceIntent)
        }
    }

    private fun tryStartService(context: Context, intent: Intent) {
        runCatching { context.startService(intent) }
    }

    companion object {
        private val HANDLED_ACTIONS = setOf(
            PomodoroContract.ACTION_PAUSE,
            PomodoroContract.ACTION_RESUME,
            PomodoroContract.ACTION_SKIP,
            PomodoroContract.ACTION_DONE,
            PomodoroContract.ACTION_PHASE_END,
        )
    }
}

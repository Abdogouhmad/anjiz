package com.freesoftware.anjiz.pomodoro

import android.app.Notification
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.annotation.RequiresApi
import com.freesoftware.anjiz.R
import java.util.Locale

/** Builds the ongoing "Live Update" notification for a running pomodoro. */
internal object PomodoroNotification {

    /** The ongoing notification for [state]; promoted to a Live Update on 36+. */
    fun buildLive(context: Context, state: PomodoroState, nowMs: Long): Notification {
        PomodoroAlert.ensureChannels(context)
        val builder = PomodoroAlert.baseBuilder(context)
            .setSmallIcon(R.drawable.ic_launcher_monochrome)
            .setContentTitle(state.title.ifBlank { "Pomodoro" })
            .setContentText(contentText(state, nowMs))
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .setContentIntent(PomodoroAlert.openAppIntent(context))
        if (state.paused) {
            builder.setWhen(0).setUsesChronometer(false)
        } else {
            builder.setWhen(state.phaseEndEpochMs)
                .setUsesChronometer(true)
                .setChronometerCountDown(true)
        }
        addProgress(builder, state, nowMs)
        if (state.paused) {
            addAction(
                builder, context, PomodoroContract.ACTION_RESUME, "Resume",
                android.R.drawable.ic_media_play, PomodoroContract.REQUEST_RESUME,
            )
        } else {
            addAction(
                builder, context, PomodoroContract.ACTION_PAUSE, "Pause",
                android.R.drawable.ic_media_pause, PomodoroContract.REQUEST_PAUSE,
            )
        }
        addAction(
            builder, context, PomodoroContract.ACTION_SKIP, "Skip",
            android.R.drawable.ic_media_next, PomodoroContract.REQUEST_SKIP,
        )
        addAction(
            builder, context, PomodoroContract.ACTION_DONE, "Done",
            R.drawable.ic_widget_checked, PomodoroContract.REQUEST_DONE,
        )
        return builder.build()
    }

    private fun contentText(state: PomodoroState, nowMs: Long): String {
        if (state.paused) {
            val remaining = PomodoroPhases.remainingOf(state, nowMs)
            val clock = String.format(
                Locale.ROOT, "%02d:%02d", remaining / 60_000L, (remaining / 1000L) % 60L,
            )
            return "Paused · $clock"
        }
        return when (state.phase) {
            PomodoroContract.PHASE_FOCUS ->
                "Focus · Session ${state.session} of ${state.totalSessions}"
            PomodoroContract.PHASE_BREAK -> "Break · ${state.breakMinutes} min"
            else -> "Long break · ${state.longBreakMinutes} min"
        }
    }

    /** Segment bar on 36+ plus the classic progress bar as a universal fallback. */
    private fun addProgress(builder: Notification.Builder, state: PomodoroState, nowMs: Long) {
        val segments = PomodoroPhases.plan(state)
        val totalMinutes = segments.sumOf { it.minutes }.coerceAtLeast(1)
        val elapsed = PomodoroPhases.elapsedMinutes(state, nowMs).coerceIn(0, totalMinutes)
        builder.setProgress(totalMinutes, elapsed, false)
        if (Build.VERSION.SDK_INT >= 36) {
            applyProgressStyle(builder, state, segments, elapsed)
            builder.setRequestPromotedOngoing(true)
        }
    }

    @RequiresApi(36)
    private fun applyProgressStyle(
        builder: Notification.Builder,
        state: PomodoroState,
        segments: List<PomodoroPhases.Segment>,
        elapsedMinutes: Int,
    ) {
        val style = Notification.ProgressStyle().setStyledByProgress(true)
        for (segment in segments) {
            val color =
                if (segment.phase == PomodoroContract.PHASE_FOCUS) {
                    state.primaryColor
                } else {
                    state.tertiaryColor
                }
            style.addProgressSegment(
                Notification.ProgressStyle.Segment(segment.minutes).setColor(color),
            )
        }
        // ProgressStyle has no setProgressMax: the max is the sum of the
        // segment lengths, i.e. the run's total minutes.
        style.setProgress(elapsedMinutes)
        builder.setStyle(style)
    }

    @Suppress("DEPRECATION")
    private fun addAction(
        builder: Notification.Builder,
        context: Context,
        action: String,
        label: String,
        icon: Int,
        requestCode: Int,
    ) {
        val intent = Intent(context, PomodoroActionReceiver::class.java).setAction(action)
        val pending = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        builder.addAction(Notification.Action.Builder(icon, label, pending).build())
    }
}

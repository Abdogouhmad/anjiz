package com.freesoftware.anjiz.pomodoro

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.media.RingtoneManager
import android.os.Build
import com.freesoftware.anjiz.R

/**
 * Notification channels, the one-shot phase-end alert and the small helpers
 * shared by the live notification and the alert.
 */
internal object PomodoroAlert {

    /** Creates both channels; inert below O where channels do not exist. */
    fun ensureChannels(context: Context) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val manager = context.getSystemService(NotificationManager::class.java) ?: return
        if (manager.getNotificationChannel(PomodoroContract.CHANNEL_LIVE) == null) {
            manager.createNotificationChannel(
                NotificationChannel(
                    PomodoroContract.CHANNEL_LIVE,
                    "Pomodoro timer",
                    NotificationManager.IMPORTANCE_DEFAULT,
                ),
            )
        }
        if (manager.getNotificationChannel(PomodoroContract.CHANNEL_ALERT) == null) {
            val channel = NotificationChannel(
                PomodoroContract.CHANNEL_ALERT,
                "Pomodoro alerts",
                NotificationManager.IMPORTANCE_HIGH,
            )
            channel.setSound(
                RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION),
                AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .build(),
            )
            channel.enableVibration(true)
            manager.createNotificationChannel(channel)
        }
    }

    /** One-shot loud ping that a phase ended; the live notification stays silent. */
    fun postPhaseEndAlert(context: Context, title: String, body: String) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        ensureChannels(context)
        val notification = Notification.Builder(context, PomodoroContract.CHANNEL_ALERT)
            .setSmallIcon(R.drawable.ic_launcher_monochrome)
            .setContentTitle(title.ifBlank { "Pomodoro" })
            .setContentText(body)
            .setAutoCancel(true)
            .setContentIntent(openAppIntent(context))
            .build()
        context.getSystemService(NotificationManager::class.java)
            ?.notify(PomodoroContract.ALERT_NOTIFICATION_ID, notification)
    }

    /** Copy for the phase-end ping: what comes next, or a small finale. */
    fun phaseEndBody(ended: PomodoroState, next: PomodoroState?): String = when {
        next == null -> "All ${ended.totalSessions} sessions complete"
        next.phase == PomodoroContract.PHASE_FOCUS ->
            "Back to focus · Session ${next.session} of ${next.totalSessions}"
        next.phase == PomodoroContract.PHASE_BREAK -> "Break · ${next.breakMinutes} min"
        else -> "Long break · ${next.longBreakMinutes} min"
    }

    /** Bare notification used only to satisfy startForeground before stopping. */
    fun buildIdle(context: Context): Notification {
        ensureChannels(context)
        return baseBuilder(context)
            .setSmallIcon(R.drawable.ic_launcher_monochrome)
            .setContentTitle("Anjiz")
            .setAutoCancel(true)
            .build()
    }

    @Suppress("DEPRECATION")
    fun baseBuilder(context: Context): Notification.Builder =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(context, PomodoroContract.CHANNEL_LIVE)
        } else {
            Notification.Builder(context)
        }

    fun openAppIntent(context: Context): PendingIntent? {
        val intent = context.packageManager.getLaunchIntentForPackage(context.packageName)
            ?.apply { addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP) } ?: return null
        return PendingIntent.getActivity(
            context, 0, intent, PendingIntent.FLAG_IMMUTABLE,
        )
    }
}

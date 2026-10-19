package com.freesoftware.anjiz.pomodoro

import android.app.Notification
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.pm.ServiceInfo
import android.os.Build

/**
 * Owns the foreground presentation of the pomodoro run: promoting the service
 * with the live notification, refreshing it, and clearing it on teardown.
 * Every API-36-only path is guarded so the class stays inert on older devices.
 */
internal object PomodoroForeground {

    /**
     * Promotes [service] to the foreground with [notification]. Uses the
     * special-use type required from API 34; the 2-arg form elsewhere.
     */
    fun promote(service: Service, notification: Notification) {
        if (Build.VERSION.SDK_INT >= 34) {
            service.startForeground(
                PomodoroContract.NOTIFICATION_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE,
            )
        } else {
            @Suppress("DEPRECATION")
            service.startForeground(PomodoroContract.NOTIFICATION_ID, notification)
        }
    }

    /**
     * Satisfies the `startForegroundService()` contract for a command that is
     * not `start`. The phase-end alarm restarts a killed process through
     * `startForegroundService()`, so every path must promote before dispatching
     * or Android flags the service as never having gone foreground.
     *
     * Returns false when there is no live run: the service is stopped again and
     * nothing is left to handle.
     */
    fun ensureForeground(service: Service): Boolean {
        val state = PomodoroState.load(service)
        if (state == null) {
            promote(service, buildIdleForContract(service))
            stop(service)
            return false
        }
        promote(service, PomodoroNotification.buildLive(service, state, System.currentTimeMillis()))
        return true
    }

    /** Refreshes the ongoing live notification with the latest [state]. */
    fun update(context: Context, state: PomodoroState, nowMs: Long) {
        val live = PomodoroNotification.buildLive(context, state, nowMs)
        manager(context)?.notify(PomodoroContract.NOTIFICATION_ID, live)
    }

    /**
     * Stops the foreground promotion and removes the notification. Used by
     * every teardown path (stop, done, run completed, pre-36 contract).
     */
    fun stop(service: Service) {
        manager(service)?.cancel(PomodoroContract.NOTIFICATION_ID)
        service.stopForeground(Service.STOP_FOREGROUND_REMOVE)
        service.stopSelf()
    }

    /** The bare notification posted only to satisfy startForegroundService. */
    fun buildIdleForContract(context: Context): Notification =
        PomodoroAlert.buildIdle(context)

    private fun manager(context: Context): NotificationManager? =
        context.getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager
}

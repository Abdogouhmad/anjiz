package com.freesoftware.anjiz.pomodoro

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent

/**
 * Arms/cancels the exact alarm that ends each pomodoro phase.
 *
 * Phase ends are AlarmManager-driven (never an in-process ticker), so they
 * fire in Doze and after the process was killed.
 */
internal object PomodoroAlarm {

    /** Fires [PomodoroContract.ACTION_PHASE_END] at [epochMs]. */
    fun schedule(context: Context, epochMs: Long) {
        val alarmManager = context.getSystemService(AlarmManager::class.java) ?: return
        val pending = phaseEndPendingIntent(context)
        try {
            // USE_EXACT_ALARM is granted at install for this app; the try/catch
            // still protects against OEMs or users revoking it.
            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, epochMs, pending)
        } catch (_: SecurityException) {
            // Without exact-alarm permission an inexact alarm keeps the timer
            // honest to within a minute instead of failing outright.
            alarmManager.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, epochMs, pending)
        }
    }

    /** Drops the pending phase-end alarm, if any. */
    fun cancel(context: Context) {
        context.getSystemService(AlarmManager::class.java)?.cancel(phaseEndPendingIntent(context))
    }

    private fun phaseEndPendingIntent(context: Context): PendingIntent {
        val intent = Intent(context, PomodoroActionReceiver::class.java)
            .setAction(PomodoroContract.ACTION_PHASE_END)
        return PendingIntent.getBroadcast(
            context,
            PomodoroContract.REQUEST_PHASE_END,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
    }
}

package com.anjiz.widget

import android.content.Context
import android.text.format.DateFormat
import com.anjiz.R
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale

/**
 * Formats task due dates without the Flutter engine.
 *
 * The widgets run in a separate process from the Dart isolate, so day and time
 * labels are rendered with the platform formatters for correct localisation.
 */
internal object WidgetDates {
    private const val ISO_WITH_MILLIS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    private const val ISO_SECONDS = "yyyy-MM-dd'T'HH:mm:ss"

    /** Builds the due label for [dueAt], or `null` when there is no due date. */
    fun label(context: Context, dueAt: String?, hasTime: Boolean): String? {
        val date = parse(dueAt) ?: return null
        val day = dayLabel(context, date)
        if (!hasTime) return day
        val time = DateFormat.getTimeFormat(context).format(date)
        return context.getString(R.string.widget_due_with_time, day, time)
    }

    private fun parse(value: String?): Date? {
        if (value.isNullOrBlank()) return null
        val cleaned = value.trim().substringBefore('+').removeSuffix("Z")
        return parseWith(cleaned, ISO_WITH_MILLIS) ?: parseWith(cleaned, ISO_SECONDS)
    }

    private fun parseWith(value: String, pattern: String): Date? =
        runCatching { SimpleDateFormat(pattern, Locale.US).parse(value) }.getOrNull()

    private fun dayLabel(context: Context, date: Date): String {
        val target = Calendar.getInstance().apply { time = date }
        if (isSameDay(Calendar.getInstance(), target)) {
            return context.getString(R.string.widget_today)
        }
        val tomorrow = Calendar.getInstance().apply { add(Calendar.DAY_OF_YEAR, 1) }
        if (isSameDay(tomorrow, target)) {
            return context.getString(R.string.widget_tomorrow)
        }
        return DateFormat.getMediumDateFormat(context).format(date)
    }

    private fun isSameDay(first: Calendar, second: Calendar): Boolean =
        first.get(Calendar.YEAR) == second.get(Calendar.YEAR) &&
            first.get(Calendar.DAY_OF_YEAR) == second.get(Calendar.DAY_OF_YEAR)
}

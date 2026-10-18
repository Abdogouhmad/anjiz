package com.freesoftware.anjiz.widget

import org.json.JSONArray
import org.json.JSONObject

/** A single task line as serialised by `WidgetSyncService` on the Flutter side. */
internal data class WidgetTask(
    val id: String,
    val title: String,
    val isDone: Boolean,
    val dueAt: String?,
    val hasTime: Boolean,
)

/** Parsed view of the JSON snapshot pushed from Flutter. */
internal data class WidgetSnapshot(
    val headerTitle: String?,
    val total: Int,
    val open: Int,
    val todayTotal: Int,
    val todayDone: Int,
    val items: List<WidgetTask>,
    val moreCount: Int,
    val opacity: Float,
) {
    /** Number of finished tasks in the current scope. */
    val done: Int get() = (total - open).coerceAtLeast(0)

    /** Fraction complete for the whole scope (fallback for old snapshots). */
    val progress: Float
        get() = fraction(done, total)

    /** Today's progress: the ring measures today, not all time. */
    val todayProgress: Float
        get() = fraction(todayDone, todayTotal)

    private fun fraction(part: Int, whole: Int): Float =
        if (whole <= 0) 0f else (part.toFloat() / whole).coerceIn(0f, 1f)

    /** Returns [count] items, with the compact layout showing fewer rows. */
    fun visible(count: Int): List<WidgetTask> = items.take(count)

    /** Rows hidden behind the "+N more" affordance for [count] visible rows. */
    fun hidden(count: Int): Int =
        moreCount + (items.size - count).coerceAtLeast(0)

    companion object {
        /** Shared-preferences key holding the serialised snapshot. */
        const val KEY = "anjiz.widget.snapshot"

        /** Snapshot used before the first Flutter sync. */
        val empty = WidgetSnapshot(null, 0, 0, 0, 0, emptyList(), 0, 1f)

        /** Parses [raw], falling back to an empty snapshot on bad input. */
        fun parse(raw: String?): WidgetSnapshot {
            if (raw.isNullOrBlank()) return empty
            return runCatching { from(JSONObject(raw)) }.getOrDefault(empty)
        }

        private fun from(json: JSONObject): WidgetSnapshot {
            val array = json.optJSONArray("items") ?: JSONArray()
            val items = (0 until array.length()).mapNotNull { index ->
                array.optJSONObject(index)?.let(::item)
            }
            val open = json.optInt("open", 0)
            val total = json.optInt("total", 0)
            val completedToday = json.optInt("completedToday", 0)
            return WidgetSnapshot(
                headerTitle = json.stringOrNull("headerTitle"),
                total = total,
                open = open,
                // Older snapshots omit the today counters: derive them.
                todayTotal = json.optInt("todayTotal", (total - open) + completedToday),
                todayDone = json.optInt("todayDone", completedToday),
                items = items,
                moreCount = json.optInt("moreCount", 0),
                opacity = json.optDouble("opacity", 1.0).toFloat(),
            )
        }

        private fun item(json: JSONObject) = WidgetTask(
            id = json.optString("id"),
            title = json.optString("title"),
            isDone = json.optBoolean("isDone", false),
            dueAt = json.stringOrNull("dueAt"),
            hasTime = json.optBoolean("hasTime", false),
        )

        private fun JSONObject.stringOrNull(key: String): String? =
            if (isNull(key)) null else optString(key).takeIf { it.isNotEmpty() }
    }
}

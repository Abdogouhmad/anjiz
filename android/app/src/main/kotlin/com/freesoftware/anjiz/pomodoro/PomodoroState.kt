package com.freesoftware.anjiz.pomodoro

import android.content.Context
import org.json.JSONObject

/**
 * One pomodoro run as a single persisted blob.
 *
 * The configuration needed to advance phases lives here too, so a phase-end
 * alarm can keep the run going after the Android process was killed.
 */
internal data class PomodoroState(
    val taskId: String,
    val title: String,
    val phase: String,
    /** 1-based index of the focus session the current phase belongs to. */
    val session: Int,
    val totalSessions: Int,
    /** Epoch ms when the current phase ends; 0 while paused. */
    val phaseEndEpochMs: Long,
    val paused: Boolean,
    /** Milliseconds left in the phase; authoritative while paused. */
    val remainingMs: Long,
    val focusMinutes: Int,
    val breakMinutes: Int,
    val longBreakMinutes: Int,
    val longBreakInterval: Int,
    val autoStartNext: Boolean,
    val primaryColor: Int,
    val tertiaryColor: Int,
) {
    /**
     * Payload shared with Dart. Both the `getState` reply and the
     * `phaseChanged`/`resumed` events use this exact shape.
     */
    fun toMap(): Map<String, Any> = mapOf(
        "phase" to phase,
        "session" to session,
        "totalSessions" to totalSessions,
        "phaseEndEpochMs" to phaseEndEpochMs,
        "paused" to paused,
        "remainingMs" to remainingMs,
    )

    fun toJson(): JSONObject = JSONObject().apply {
        put("taskId", taskId)
        put("title", title)
        put("phase", phase)
        put("session", session)
        put("totalSessions", totalSessions)
        put("phaseEndEpochMs", phaseEndEpochMs)
        put("paused", paused)
        put("remainingMs", remainingMs)
        put("focusMinutes", focusMinutes)
        put("breakMinutes", breakMinutes)
        put("longBreakMinutes", longBreakMinutes)
        put("longBreakInterval", longBreakInterval)
        put("autoStartNext", autoStartNext)
        put("primaryColor", primaryColor)
        put("tertiaryColor", tertiaryColor)
    }

    companion object {
        /** Restores the persisted run, or null when no run is active. */
        fun load(context: Context): PomodoroState? {
            val raw = prefs(context).getString(PomodoroContract.PREFS_STATE_KEY, null)
            if (raw.isNullOrBlank()) return null
            return runCatching { fromJson(JSONObject(raw)) }.getOrNull()
        }

        /** Persists [state]; passing null clears the stored run. */
        fun save(context: Context, state: PomodoroState?) {
            val editor = prefs(context).edit()
            if (state == null) {
                editor.remove(PomodoroContract.PREFS_STATE_KEY)
            } else {
                editor.putString(PomodoroContract.PREFS_STATE_KEY, state.toJson().toString())
            }
            editor.apply()
        }

        private fun prefs(context: Context) =
            context.getSharedPreferences(PomodoroContract.PREFS_NAME, Context.MODE_PRIVATE)

        private fun fromJson(json: JSONObject) = PomodoroState(
            taskId = json.optString("taskId"),
            title = json.optString("title"),
            phase = json.optString("phase", PomodoroContract.PHASE_FOCUS),
            session = json.optInt("session", 1),
            totalSessions = json.optInt("totalSessions", 1),
            phaseEndEpochMs = json.optLong("phaseEndEpochMs"),
            paused = json.optBoolean("paused"),
            remainingMs = json.optLong("remainingMs"),
            focusMinutes = json.optInt("focusMinutes", 25),
            breakMinutes = json.optInt("breakMinutes", 5),
            longBreakMinutes = json.optInt("longBreakMinutes", 15),
            longBreakInterval = json.optInt("longBreakInterval", 4),
            autoStartNext = json.optBoolean("autoStartNext", true),
            primaryColor = json.optInt("primaryColor", PomodoroContract.DEFAULT_PRIMARY_COLOR),
            tertiaryColor = json.optInt("tertiaryColor", PomodoroContract.DEFAULT_TERTIARY_COLOR),
        )
    }
}

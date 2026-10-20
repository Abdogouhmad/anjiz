package com.freesoftware.anjiz.pomodoro

/**
 * Pure phase arithmetic for a pomodoro run. No Android APIs, so it stays
 * trivially testable and reusable from the service and the notification.
 */
internal object PomodoroPhases {

    /** One phase of the whole run: focus/break/longBreak and its length. */
    data class Segment(val phase: String, val session: Int, val minutes: Int)

    /** Length in minutes of the phase currently running in [state]. */
    fun minutesOf(state: PomodoroState): Int = when (state.phase) {
        PomodoroContract.PHASE_FOCUS -> state.focusMinutes
        PomodoroContract.PHASE_BREAK -> state.breakMinutes
        else -> state.longBreakMinutes
    }

    /** Milliseconds left in the current phase (authoritative while paused). */
    fun remainingOf(state: PomodoroState, nowMs: Long): Long =
        if (state.paused) {
            state.remainingMs
        } else {
            (state.phaseEndEpochMs - nowMs).coerceAtLeast(0)
        }

    /**
     * State of the phase following the one in [state], or null when the last
     * focus session of the run has just finished. Timing fields are reset to
     * a full phase; the caller decides whether to start or pause it.
     */
    fun advance(state: PomodoroState): PomodoroState? {
        if (state.phase == PomodoroContract.PHASE_FOCUS) {
            if (state.session >= state.totalSessions) return null // whole run done
            // A long break closes every longBreakInterval focus sessions.
            val longBreak = state.session % state.longBreakInterval == 0
            return state.copy(
                phase = if (longBreak) {
                    PomodoroContract.PHASE_LONG_BREAK
                } else {
                    PomodoroContract.PHASE_BREAK
                },
                remainingMs = minutesOf(state.session, longBreak, state),
            )
        }
        return state.copy(
            phase = PomodoroContract.PHASE_FOCUS,
            session = state.session + 1,
            remainingMs = state.focusMinutes * MINUTE_MS,
        )
    }

    /** The run as an ordered list of phases — the ProgressStyle segments. */
    fun plan(state: PomodoroState): List<Segment> = buildList {
        for (session in 1..state.totalSessions) {
            add(Segment(PomodoroContract.PHASE_FOCUS, session, state.focusMinutes))
            if (session >= state.totalSessions) break
            val longBreak = session % state.longBreakInterval == 0
            add(
                Segment(
                    if (longBreak) PomodoroContract.PHASE_LONG_BREAK
                    else PomodoroContract.PHASE_BREAK,
                    session,
                    if (longBreak) state.longBreakMinutes else state.breakMinutes,
                )
            )
        }
    }

    /** Minutes already elapsed inside the whole run (the tracker position). */
    fun elapsedMinutes(state: PomodoroState, nowMs: Long): Int {
        var elapsed = 0
        for (segment in plan(state)) {
            val current = segment.phase == state.phase && segment.session == state.session
            if (!current) {
                elapsed += segment.minutes
                continue
            }
            val spent = (minutesOf(state) * MINUTE_MS - remainingOf(state, nowMs)) / MINUTE_MS
            return elapsed + spent.toInt().coerceIn(0, segment.minutes)
        }
        return elapsed // phase not in the plan (finished): report the total
    }

    private fun minutesOf(session: Int, longBreak: Boolean, state: PomodoroState): Long =
        (if (longBreak) state.longBreakMinutes else state.breakMinutes) * MINUTE_MS

    private const val MINUTE_MS = 60_000L
}

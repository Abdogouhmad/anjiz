package com.freesoftware.anjiz.pomodoro

/**
 * Applies [PomodoroPhases.advance] results to the run.
 *
 * Keeping the "start it or hold it paused" decision here leaves
 * [PomodoroService] a thin action dispatcher.
 */
internal object PomodoroRun {

    private const val MINUTE_MS = 60_000L

    /**
     * The state [next] should be entered in at [nowMs]: running with an alarm
     * deadline, or paused on the full phase length when autoStartNext is off.
     * Returns null when [next] is null, i.e. the whole run just finished.
     */
    fun entered(next: PomodoroState?, nowMs: Long): PomodoroState? {
        next ?: return null
        val length = PomodoroPhases.minutesOf(next) * MINUTE_MS
        return if (next.autoStartNext) {
            next.copy(phaseEndEpochMs = nowMs + length, paused = false, remainingMs = 0)
        } else {
            next.copy(phaseEndEpochMs = 0, paused = true, remainingMs = length)
        }
    }

    /** The "all done" state persisted after the final focus session. */
    fun completed(state: PomodoroState): PomodoroState =
        state.copy(phaseEndEpochMs = 0, paused = true, remainingMs = 0)
}

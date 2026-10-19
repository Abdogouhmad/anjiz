package com.freesoftware.anjiz.pomodoro

/**
 * Names, actions and ids shared between the Flutter side, the channel handler,
 * the service and the action receiver. Keep the channel name and event/payload
 * shapes in sync with `lib/features/pomodoro`.
 */
internal object PomodoroContract {
    /** MethodChannel name registered by [PomodoroChannelHandler]. */
    const val CHANNEL_NAME = "anjiz/pomodoro"

    /** Prefix for every broadcast/service action of this feature. */
    const val ACTION_PREFIX = "com.freesoftware.anjiz.pomodoro."

    // Notification action / alarm broadcasts (handled by PomodoroActionReceiver).
    const val ACTION_PAUSE = "${ACTION_PREFIX}pause"
    const val ACTION_RESUME = "${ACTION_PREFIX}resume"
    const val ACTION_SKIP = "${ACTION_PREFIX}skip"
    const val ACTION_DONE = "${ACTION_PREFIX}done"
    const val ACTION_PHASE_END = "${ACTION_PREFIX}phase_end"

    // Commands forwarded from Dart through the method channel.
    const val ACTION_START = "${ACTION_PREFIX}start"
    const val ACTION_STOP = "${ACTION_PREFIX}stop"

    // Intent extras for ACTION_START (numeric extras arrive as Number because
    // Dart ints bigger than 32 bits decode to Long).
    const val EXTRA_TASK_ID = "taskId"
    const val EXTRA_TITLE = "title"
    const val EXTRA_FOCUS_MINUTES = "focusMinutes"
    const val EXTRA_BREAK_MINUTES = "breakMinutes"
    const val EXTRA_LONG_BREAK_MINUTES = "longBreakMinutes"
    const val EXTRA_LONG_BREAK_INTERVAL = "longBreakInterval"
    const val EXTRA_TOTAL_SESSIONS = "totalSessions"
    const val EXTRA_AUTO_START_NEXT = "autoStartNext"
    const val EXTRA_PRIMARY_COLOR = "primaryColor"
    const val EXTRA_TERTIARY_COLOR = "tertiaryColor"

    /** Notification ids: the promoted live timer + the phase-end ping. */
    const val NOTIFICATION_ID = 4100
    const val ALERT_NOTIFICATION_ID = 4101

    /** Notification channels: ongoing live update vs. loud one-shot alert. */
    const val CHANNEL_LIVE = "pomodoro"
    const val CHANNEL_ALERT = "pomodoro_alert"

    /** SharedPreferences file/key so the run survives process death. */
    const val PREFS_NAME = "anjiz.pomodoro"
    const val PREFS_STATE_KEY = "state"

    /** Phase names — identical to the strings Dart uses in its events. */
    const val PHASE_FOCUS = "focus"
    const val PHASE_BREAK = "break"
    const val PHASE_LONG_BREAK = "longBreak"

    /** PendingIntent request codes; one per action so taps stay distinct. */
    const val REQUEST_PAUSE = 41010
    const val REQUEST_RESUME = 41011
    const val REQUEST_SKIP = 41012
    const val REQUEST_DONE = 41013
    const val REQUEST_PHASE_END = 41014

    /** Fallback ARGB colors: the dynamic-color seed / a Material tertiary. */
    val DEFAULT_PRIMARY_COLOR: Int = 0xFF1B7A66.toInt()
    val DEFAULT_TERTIARY_COLOR: Int = 0xFF6750A4.toInt()
}

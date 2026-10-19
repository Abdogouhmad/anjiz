package com.freesoftware.anjiz.pomodoro

import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.lang.ref.WeakReference

/**
 * The `anjiz/pomodoro` method channel: Dart commands in, service events out.
 *
 * Dart -> native: `getSdkVersion`, `canPostPromoted`, `getState`, `start`,
 * `pause`, `resume`, `skip`, `stop`. Native -> Dart events: `phaseChanged`,
 * `paused`, `resumed`, `completed`, `done`.
 *
 * The channel is only referenced weakly, so [PomodoroService] can keep firing
 * events after the engine is gone without crashing or leaking it.
 */
internal object PomodoroChannelHandler : MethodChannel.MethodCallHandler {

    private val mainHandler = Handler(Looper.getMainLooper())
    private var channelRef: WeakReference<MethodChannel>? = null
    private var appContext: Context? = null

    /** Called from `MainActivity.configureFlutterEngine`. */
    fun register(context: Context, engine: FlutterEngine) {
        appContext = context.applicationContext
        val channel = MethodChannel(
            engine.dartExecutor.binaryMessenger,
            PomodoroContract.CHANNEL_NAME,
        )
        channel.setMethodCallHandler(this)
        channelRef = WeakReference(channel)
    }

    /** Drops the channel when the engine goes away. */
    fun detach() {
        channelRef?.get()?.setMethodCallHandler(null)
        channelRef = null
        appContext = null
    }

    /** Pushes a service event to Dart; a no-op when no engine is attached. */
    fun send(event: String, arguments: Any?) {
        val channel = channelRef?.get() ?: return
        if (Looper.myLooper() == Looper.getMainLooper()) {
            channel.invokeMethod(event, arguments)
        } else {
            mainHandler.post { channel.invokeMethod(event, arguments) }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val context = appContext
        if (context == null) {
            result.error("detached", "pomodoro channel has no engine", null)
            return
        }
        try {
            when (call.method) {
                "getSdkVersion" -> result.success(Build.VERSION.SDK_INT)
                "canPostPromoted" -> result.success(canPostPromoted(context))
                "getState" -> result.success(PomodoroState.load(context)?.toMap())
                "start" -> {
                    start(context, call)
                    result.success(true)
                }
                // "pause"/"resume"/"skip"/"stop" map 1:1 onto the action names.
                "pause", "resume", "skip", "stop" -> {
                    sendToService(
                        context,
                        PomodoroService.commandIntent(
                            context,
                            "${PomodoroContract.ACTION_PREFIX}${call.method}",
                        ),
                    )
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            result.error("pomodoro_error", e.message, null)
        }
    }

    private fun canPostPromoted(context: Context): Boolean {
        if (!NotificationManagerCompat.from(context).areNotificationsEnabled()) return false
        // Promoted "Live Update" notifications only exist from Android 16.
        if (Build.VERSION.SDK_INT < 36) return false
        return NotificationManagerCompat.canPostPromotedNotifications()
    }

    private fun start(context: Context, call: MethodCall) {
        val interval = intArg(call, "longBreakInterval", 4)
        val intent = PomodoroService.commandIntent(context, PomodoroContract.ACTION_START)
            .putExtra(PomodoroContract.EXTRA_TASK_ID, call.argument<String>("taskId").orEmpty())
            .putExtra(PomodoroContract.EXTRA_TITLE, call.argument<String>("title").orEmpty())
            .putExtra(PomodoroContract.EXTRA_FOCUS_MINUTES, intArg(call, "focusMinutes", 25))
            .putExtra(PomodoroContract.EXTRA_BREAK_MINUTES, intArg(call, "breakMinutes", 5))
            .putExtra(
                PomodoroContract.EXTRA_LONG_BREAK_MINUTES,
                intArg(call, "longBreakMinutes", 15),
            )
            .putExtra(PomodoroContract.EXTRA_LONG_BREAK_INTERVAL, interval)
            .putExtra(PomodoroContract.EXTRA_TOTAL_SESSIONS, intArg(call, "totalSessions", interval))
            .putExtra(
                PomodoroContract.EXTRA_AUTO_START_NEXT,
                call.argument<Boolean>("autoStartNext") ?: true,
            )
            .putExtra(
                PomodoroContract.EXTRA_PRIMARY_COLOR,
                colorArg(call, "primaryColor", PomodoroContract.DEFAULT_PRIMARY_COLOR),
            )
            .putExtra(
                PomodoroContract.EXTRA_TERTIARY_COLOR,
                colorArg(call, "tertiaryColor", PomodoroContract.DEFAULT_TERTIARY_COLOR),
            )
        sendToService(context, intent)
    }

    /** Dart colors above Int.MAX decode to Long, so accept any Number. */
    private fun colorArg(call: MethodCall, key: String, fallback: Int): Int =
        call.argument<Number>(key)?.toInt() ?: fallback

    private fun intArg(call: MethodCall, key: String, fallback: Int): Int =
        (call.argument<Number>(key)?.toInt() ?: fallback).coerceAtLeast(1)

    /** startForegroundService on O+, plain startService as a last resort. */
    private fun sendToService(context: Context, intent: Intent) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(intent)
        } else {
            context.startService(intent)
        }
    }
}

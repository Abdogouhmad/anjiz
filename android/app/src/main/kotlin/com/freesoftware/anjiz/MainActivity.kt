package com.freesoftware.anjiz

import com.freesoftware.anjiz.pomodoro.PomodoroChannelHandler
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(engine: FlutterEngine) {
        super.configureFlutterEngine(engine)
        PomodoroChannelHandler.register(this, engine)
    }

    override fun cleanUpFlutterEngine(engine: FlutterEngine) {
        PomodoroChannelHandler.detach()
        super.cleanUpFlutterEngine(engine)
    }
}

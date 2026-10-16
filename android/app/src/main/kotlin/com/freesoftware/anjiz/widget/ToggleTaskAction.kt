package com.freesoftware.anjiz.widget

import android.content.Context
import androidx.glance.GlanceId
import androidx.glance.action.ActionParameters
import androidx.glance.appwidget.action.ActionCallback
import es.antonborri.home_widget.HomeWidgetBackgroundIntent

/**
 * Forwards a Glance row tap to the Flutter background isolate.
 *
 * Glance actions run inside the widget process, so the tap is re-emitted as a
 * `home_widget` background broadcast that `anjizWidgetCallback` handles.
 *
 * Instantiated reflectively by Glance, so this class must stay public with a
 * zero-argument constructor.
 */
class ToggleTaskAction : ActionCallback {
    override suspend fun onAction(
        context: Context,
        glanceId: GlanceId,
        parameters: ActionParameters,
    ) {
        val taskId = parameters[WidgetContract.taskIdKey] ?: return
        HomeWidgetBackgroundIntent
            .getBroadcast(context, WidgetContract.toggleTask(taskId))
            .send()
    }
}

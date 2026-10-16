package com.anjiz.widget

import android.net.Uri
import androidx.glance.action.ActionParameters
import androidx.glance.action.actionParametersOf

/**
 * Deep links and action keys shared with the Flutter side.
 *
 * The Dart background callback (`anjizWidgetCallback`) understands the same
 * scheme; keep both sides in sync.
 */
internal object WidgetContract {
    /** Deep-link scheme used for every widget interaction. */
    const val SCHEME = "anjiz"

    /** Route that opens the app on the Today tab. */
    const val ROUTE_TODAY = "today"

    /** Route that opens the quick-add composer. */
    const val ROUTE_QUICK_ADD = "quick-add"

    /** Route that groups task interactions. */
    const val ROUTE_TASK = "task"

    /** Query parameter carrying the tapped task id. */
    const val PARAM_TASK_ID = "id"

    /** Glance action parameter carrying the tapped task id. */
    val taskIdKey = ActionParameters.Key<String>("anjiz.taskId")

    /** Deep link that opens the app on Today. */
    fun today(): Uri = Uri.parse("$SCHEME://$ROUTE_TODAY")

    /** Deep link that opens the quick-add composer. */
    fun quickAdd(): Uri = Uri.parse("$SCHEME://$ROUTE_QUICK_ADD")

    /** Deep link handed to the Flutter background isolate to toggle [taskId]. */
    fun toggleTask(taskId: String): Uri = Uri.parse("$SCHEME://$ROUTE_TASK/toggle")
        .buildUpon()
        .appendQueryParameter(PARAM_TASK_ID, taskId)
        .build()

    /** Glance action parameters for a single task row. */
    fun taskParams(taskId: String) = actionParametersOf(taskIdKey to taskId)
}

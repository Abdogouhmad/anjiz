package com.freesoftware.anjiz.widget

import HomeWidgetGlanceWidgetReceiver

/** AppWidget provider that hosts the [TasksOverviewWidget] Glance surface. */
class TasksOverviewWidgetProvider : HomeWidgetGlanceWidgetReceiver<TasksOverviewWidget>() {
    override val glanceAppWidget = TasksOverviewWidget()
}

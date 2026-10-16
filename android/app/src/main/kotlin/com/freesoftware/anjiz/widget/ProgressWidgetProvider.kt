package com.freesoftware.anjiz.widget

import HomeWidgetGlanceWidgetReceiver

/** AppWidget provider that hosts the [ProgressWidget] Glance surface. */
class ProgressWidgetProvider : HomeWidgetGlanceWidgetReceiver<ProgressWidget>() {
    override val glanceAppWidget = ProgressWidget()
}

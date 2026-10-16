package com.anjiz.widget

import HomeWidgetGlanceWidgetReceiver

/** AppWidget provider that hosts the [QuickAddWidget] Glance surface. */
class QuickAddWidgetProvider : HomeWidgetGlanceWidgetReceiver<QuickAddWidget>() {
    override val glanceAppWidget = QuickAddWidget()
}

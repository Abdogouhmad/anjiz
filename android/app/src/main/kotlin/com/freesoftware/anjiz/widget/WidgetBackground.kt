package com.freesoftware.anjiz.widget

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.glance.GlanceTheme
import androidx.glance.unit.ColorProvider

/**
 * The widget surface colour, honouring the opacity set in Anjiz settings.
 *
 * The base tone comes from [GlanceTheme], which resolves to the device's
 * Material You palette on Android 12+ and to the Material 3 baseline below it.
 */
@Composable
internal fun widgetBackground(context: Context, opacity: Float): ColorProvider {
    val base = GlanceTheme.colors.widgetBackground
    if (opacity >= 1f) return base
    val translucent: Color = base.getColor(context).copy(alpha = opacity.coerceIn(0.1f, 1f))
    return ColorProvider(translucent)
}

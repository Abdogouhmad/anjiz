package com.anjiz.widget

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.ColorFilter
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.layout.width
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import com.anjiz.MainActivity
import com.anjiz.R
import es.antonborri.home_widget.HomeWidgetGlanceState
import es.antonborri.home_widget.HomeWidgetGlanceStateDefinition
import es.antonborri.home_widget.actionStartActivity

/**
 * The 4x1 Quick add widget: a single tap target that opens the composer.
 */
class QuickAddWidget : GlanceAppWidget() {
    override val stateDefinition = HomeWidgetGlanceStateDefinition()

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            GlanceTheme {
                val preferences = currentState<HomeWidgetGlanceState>().preferences
                val snapshot = WidgetSnapshot.parse(
                    preferences.getString(WidgetSnapshot.KEY, null),
                )
                QuickAddContent(context, snapshot.opacity)
            }
        }
    }
}

@Composable
private fun QuickAddContent(context: Context, opacity: Float) {
    val colors = GlanceTheme.colors
    Row(
        modifier = GlanceModifier
            .fillMaxSize()
            .background(widgetBackground(context, opacity))
            .cornerRadius(24.dp)
            .padding(horizontal = 16.dp)
            .clickable(
                onClick = actionStartActivity<MainActivity>(context, WidgetContract.quickAdd()),
            ),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Image(
            provider = ImageProvider(R.drawable.ic_widget_add),
            contentDescription = "",
            modifier = GlanceModifier.size(22.dp),
            colorFilter = ColorFilter.tint(colors.primary),
        )
        Spacer(GlanceModifier.width(12.dp))
        Text(
            text = context.getString(R.string.widget_quick_add_hint),
            style = TextStyle(
                color = colors.onSurface,
                fontSize = 15.sp,
                fontWeight = FontWeight.Medium,
            ),
            maxLines = 1,
        )
    }
}

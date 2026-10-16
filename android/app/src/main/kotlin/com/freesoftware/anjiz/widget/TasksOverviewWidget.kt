package com.freesoftware.anjiz.widget

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.ColorFilter
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.LocalSize
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.SizeMode
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import com.freesoftware.anjiz.MainActivity
import com.freesoftware.anjiz.R
import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import es.antonborri.home_widget.actionStartActivity

/**
 * The Tasks Overview widget.
 *
 * Renders a list-switcher header, an add button and the next tasks. The layout
 * breathes from the 4x4 grid down to the 4x2 compact list using [SizeMode].
 */
class TasksOverviewWidget : GlanceAppWidget() {
    override val stateDefinition = HomeWidgetGlanceStateDefinition()

    override val sizeMode: SizeMode = SizeMode.Responsive(SIZES)

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            GlanceTheme {
                val preferences = currentState<HomeWidgetGlanceState>().preferences
                val snapshot = WidgetSnapshot.parse(
                    preferences.getString(WidgetSnapshot.KEY, null),
                )
                val rows = if (LocalSize.current.height < COMPACT_HEIGHT) 3 else 6
                TasksOverviewContent(context, snapshot, rows)
            }
        }
    }

    private companion object {
        val COMPACT_HEIGHT = 140.dp
        val SIZES = setOf(DpSize(180.dp, 110.dp), DpSize(180.dp, 240.dp))
    }
}

@Composable
private fun TasksOverviewContent(
    context: Context,
    snapshot: WidgetSnapshot,
    rows: Int,
) {
    val colors = GlanceTheme.colors
    Column(
        modifier = GlanceModifier
            .fillMaxSize()
            .background(widgetBackground(context, snapshot.opacity))
            .cornerRadius(20.dp)
            .padding(horizontal = 14.dp, vertical = 10.dp),
    ) {
        Header(context, snapshot)
        if (snapshot.items.isEmpty()) {
            Text(
                text = context.getString(R.string.widget_empty),
                modifier = GlanceModifier.padding(vertical = 10.dp),
                style = TextStyle(color = colors.onSurfaceVariant, fontSize = 13.sp),
                maxLines = 1,
            )
            return@Column
        }
        snapshot.visible(rows).forEach { WidgetTaskRow(context, it) }
        val hidden = snapshot.hidden(rows)
        if (hidden > 0) {
            Text(
                text = context.getString(R.string.widget_more, hidden),
                modifier = GlanceModifier.padding(top = 4.dp),
                style = TextStyle(
                    color = colors.primary,
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Medium,
                ),
                maxLines = 1,
            )
        }
    }
}

@Composable
private fun Header(context: Context, snapshot: WidgetSnapshot) {
    val colors = GlanceTheme.colors
    Row(
        modifier = GlanceModifier.fillMaxWidth().padding(bottom = 6.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Text(
            text = snapshot.headerTitle ?: context.getString(R.string.widget_all_tasks),
            modifier = GlanceModifier.defaultWeight().clickable(
                onClick = actionStartActivity<MainActivity>(context, WidgetContract.today()),
            ),
            style = TextStyle(
                color = colors.onSurfaceVariant,
                fontSize = 13.sp,
                fontWeight = FontWeight.Medium,
            ),
            maxLines = 1,
        )
        Image(
            provider = ImageProvider(R.drawable.ic_widget_add),
            contentDescription = context.getString(R.string.widget_quick_add_hint),
            modifier = GlanceModifier.size(24.dp).clickable(
                onClick = actionStartActivity<MainActivity>(context, WidgetContract.quickAdd()),
            ),
            colorFilter = ColorFilter.tint(colors.primary),
        )
    }
}

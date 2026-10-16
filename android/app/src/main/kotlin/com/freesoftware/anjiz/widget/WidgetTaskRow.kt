package com.freesoftware.anjiz.widget

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.ColorFilter
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.action.clickable
import androidx.glance.appwidget.action.actionRunCallback
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.layout.width
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextDecoration
import androidx.glance.text.TextStyle
import com.freesoftware.anjiz.R

/**
 * One tappable task line: a completion dot, the title and an optional due label.
 *
 * Tapping anywhere on the row toggles the task through [ToggleTaskAction].
 */
@Composable
internal fun WidgetTaskRow(context: Context, task: WidgetTask) {
    val colors = GlanceTheme.colors
    Row(
        modifier = GlanceModifier
            .fillMaxWidth()
            .clickable(
                onClick = actionRunCallback<ToggleTaskAction>(
                    WidgetContract.taskParams(task.id),
                ),
            )
            .padding(vertical = 5.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Image(
            provider = ImageProvider(
                if (task.isDone) R.drawable.ic_widget_checked else R.drawable.ic_widget_unchecked,
            ),
            contentDescription = "",
            modifier = GlanceModifier.size(18.dp),
            colorFilter = ColorFilter.tint(if (task.isDone) colors.primary else colors.outline),
        )
        Spacer(GlanceModifier.width(10.dp))
        Column(modifier = GlanceModifier.defaultWeight()) {
            Text(
                text = task.title,
                style = TextStyle(
                    color = if (task.isDone) colors.onSurfaceVariant else colors.onSurface,
                    fontSize = 14.sp,
                    fontWeight = FontWeight.Medium,
                    textDecoration = if (task.isDone) {
                        TextDecoration.LineThrough
                    } else {
                        TextDecoration.None
                    },
                ),
                maxLines = 1,
            )
            WidgetDates.label(context, task.dueAt, task.hasTime)?.let { label ->
                Text(
                    text = label,
                    style = TextStyle(
                        color = colors.onSurfaceVariant,
                        fontSize = 11.sp,
                    ),
                    maxLines = 1,
                )
            }
        }
    }
}

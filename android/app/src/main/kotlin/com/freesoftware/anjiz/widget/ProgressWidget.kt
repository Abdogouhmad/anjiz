package com.freesoftware.anjiz.widget

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.LinearProgressIndicator
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import com.freesoftware.anjiz.MainActivity
import com.freesoftware.anjiz.R
import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import es.antonborri.home_widget.actionStartActivity

/**
 * The 2x2 Progress widget: a "done/total" headline over a determinate bar.
 *
 * The bar mirrors the app's linear progress component, which Glance renders
 * with the Material You accent for the home screen.
 */
class ProgressWidget : GlanceAppWidget() {
    override val stateDefinition = HomeWidgetGlanceStateDefinition()

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            GlanceTheme {
                val preferences = currentState<HomeWidgetGlanceState>().preferences
                val snapshot = WidgetSnapshot.parse(
                    preferences.getString(WidgetSnapshot.KEY, null),
                )
                ProgressContent(context, snapshot)
            }
        }
    }
}

@Composable
private fun ProgressContent(context: Context, snapshot: WidgetSnapshot) {
    val colors = GlanceTheme.colors
    Column(
        modifier = GlanceModifier
            .fillMaxSize()
            .background(widgetBackground(context, snapshot.opacity))
            .cornerRadius(24.dp)
            .padding(16.dp)
            .clickable(
                onClick = actionStartActivity<MainActivity>(context, WidgetContract.today()),
            ),
        verticalAlignment = Alignment.CenterVertically,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Text(
            text = context.getString(R.string.widget_progress_title),
            style = TextStyle(
                color = colors.onSurfaceVariant,
                fontSize = 12.sp,
                fontWeight = FontWeight.Medium,
            ),
            maxLines = 1,
        )
        Spacer(GlanceModifier.height(4.dp))
        Text(
            text = context.getString(
                R.string.widget_progress_value,
                snapshot.todayDone,
                snapshot.todayTotal,
            ),
            style = TextStyle(
                color = colors.primary,
                fontSize = 32.sp,
                fontWeight = FontWeight.Bold,
            ),
            maxLines = 1,
        )
        Spacer(GlanceModifier.height(10.dp))
        LinearProgressIndicator(
            progress = snapshot.todayProgress,
            modifier = GlanceModifier.fillMaxWidth().height(8.dp).cornerRadius(4.dp),
            color = colors.primary,
            backgroundColor = colors.surfaceVariant,
        )
    }
}

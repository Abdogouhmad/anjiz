import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';

/// A nested settings screen: a collapsing app bar with a back button and a
/// single column of cards that clears the floating navigation bar.
class SettingsSubScreen extends StatelessWidget {
  /// Creates a nested settings screen.
  const SettingsSubScreen({
    required this.title,
    required this.children,
    this.subtitle,
    super.key,
  });

  /// App-bar title.
  final String title;

  /// Optional app-bar subtitle.
  final String? subtitle;

  /// The cards to render, in order.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final margin = AnjizBreakpoints.margin(AnjizBreakpoints.of(context));
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            AnjizLargeAppBar(
              title: title,
              subtitle: subtitle,
              // Fall back to the hub when this screen is opened directly (a
              // cold start on a deep link leaves nothing to pop).
              leading: BackButton(
                onPressed: () => context.canPop()
                    ? context.pop()
                    : context.go(AppRoutes.settings),
              ),
            ),
            SliverPadding(
              padding: EdgeInsetsDirectional.fromSTEB(
                margin,
                AnjizSpacing.sm,
                margin,
                // Clear the floating glass navigation bar.
                AnjizSpacing.xxl + AnjizFloatingNavBar.contentBottomInset,
              ),
              sliver: SliverList.list(children: children),
            ),
          ],
        ),
      ),
    );
  }
}

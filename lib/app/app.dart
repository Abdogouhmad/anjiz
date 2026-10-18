import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/settings/settings.dart';
import '../l10n/app_localizations.dart';
import 'router.dart';

/// The root Anjiz widget: theme resolution, localisation and routing.
class AnjizApp extends ConsumerWidget {
  /// Creates the application.
  const AnjizApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final router = ref.watch(routerProvider);
    final useSeed = !settings.useDynamicColor && settings.accentIndex != 0;
    return AnjizDynamicTheme(
      useDynamicColor: settings.useDynamicColor,
      seedColor: useSeed ? accentSeedFor(settings.accentIndex) : null,
      pureBlackDark: settings.usePureBlack,
      builder: (context, lightTheme, darkTheme) => MaterialApp.router(
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: settings.themeMode,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
  }
}

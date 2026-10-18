import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the `flutter_local_notifications` manifest contract.
///
/// Without these declarations scheduled notifications never reach the user
/// (the root cause of v0.1.1's dead reminders): AlarmManager delivers alarms
/// to `ScheduledNotificationReceiver`, notification action buttons (Snooze)
/// go through `ActionBroadcastReceiver` and `ScheduledNotificationBootReceiver`
/// restores pending alarms after a reboot or app update. The plugin's own
/// manifest declares none of them — the app must.
void main() {
  final manifest = File('android/app/src/main/AndroidManifest.xml')
      .readAsStringSync();

  const plugin = 'com.dexterous.flutterlocalnotifications';
  const requiredSnippets = <String, String>{
    'delivers scheduled notifications':
        '<receiver\n            android:name="$plugin.ScheduledNotificationReceiver"',
    'dispatches notification action buttons (snooze)':
        '<receiver\n            android:name="$plugin.ActionBroadcastReceiver"',
    'restores scheduled notifications after reboot':
        '<receiver\n            android:name="$plugin.ScheduledNotificationBootReceiver"',
    'reboots re-schedule pending alarms':
        '<action android:name="android.intent.action.BOOT_COMPLETED"',
    'exact reminders on Android 12+':
        '<uses-permission android:name="android.permission.USE_EXACT_ALARM"',
    'notifications on Android 13+':
        '<uses-permission android:name="android.permission.POST_NOTIFICATIONS"',
  };

  group('AndroidManifest.xml notification contract', () {
    requiredSnippets.forEach((why, snippet) {
      test('declares $why', () {
        expect(
          manifest,
          contains(snippet),
          reason:
              'Missing "$snippet" — notifications silently stop working. '
              'See flutter_local_notifications README setup section.',
        );
      });
    });
  });
}

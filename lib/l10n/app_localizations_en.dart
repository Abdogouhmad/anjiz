// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Anjiz';

  @override
  String get appTagline => 'Achieve today';

  @override
  String get navToday => 'Today';

  @override
  String get navUpcoming => 'Upcoming';

  @override
  String get navLists => 'Lists';

  @override
  String get navSettings => 'Settings';

  @override
  String get actionNewTask => 'New Task';

  @override
  String get actionAddTask => 'Add Task';

  @override
  String get actionAddAnother => 'Add Another';

  @override
  String get actionAddSubtask => 'Add subtask';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionSave => 'Save';

  @override
  String get actionDone => 'Done';

  @override
  String get actionUndo => 'Undo';

  @override
  String get actionRetry => 'Retry';

  @override
  String get actionChange => 'Change';

  @override
  String get actionClear => 'Clear';

  @override
  String get actionClose => 'Close';

  @override
  String get actionSkip => 'Skip';

  @override
  String get actionNext => 'Next';

  @override
  String get actionGetStarted => 'Get started';

  @override
  String get actionMarkComplete => 'Mark Complete';

  @override
  String get actionShare => 'Share';

  @override
  String get actionSnooze => 'Snooze';

  @override
  String get actionAddVoiceNote => 'Voice note';

  @override
  String get actionNewList => 'New List';

  @override
  String get actionRescheduleAll => 'Reschedule all';

  @override
  String get actionPlanTomorrow => 'Plan Tomorrow';

  @override
  String get actionReviewCompleted => 'Review Completed Tasks';

  @override
  String get actionFullCalendar => 'Full Calendar';

  @override
  String get actionManagePlan => 'Manage Plan';

  @override
  String get actionOptions => 'Options';

  @override
  String get actionExpandMenu => 'Show more actions';

  @override
  String get actionCollapseMenu => 'Hide actions';

  @override
  String get actionStarTask => 'Star task';

  @override
  String get actionUnstarTask => 'Unstar task';

  @override
  String actionCompleteTask(String title) {
    return 'Complete $title';
  }

  @override
  String get searchHint => 'Search tasks';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchEmptyTitle => 'No matches';

  @override
  String get searchEmptyMessage =>
      'Try a different word or check another list.';

  @override
  String get searchPromptTitle => 'Find anything';

  @override
  String get searchPromptMessage =>
      'Search across every task by title or note.';

  @override
  String get todaySubtitle => 'Achieve today';

  @override
  String get greetingMorning => 'Good morning!';

  @override
  String get greetingAfternoon => 'Good afternoon!';

  @override
  String get greetingEvening => 'Good evening!';

  @override
  String greetingMorningNamed(String name) {
    return 'Good morning, $name!';
  }

  @override
  String greetingAfternoonNamed(String name) {
    return 'Good afternoon, $name!';
  }

  @override
  String greetingEveningNamed(String name) {
    return 'Good evening, $name!';
  }

  @override
  String todaySummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks left for a peaceful evening.',
      one: '1 task left for a peaceful evening.',
      zero: 'Nothing left for a peaceful evening.',
    );
    return '$_temp0';
  }

  @override
  String get sectionOverdue => 'Overdue';

  @override
  String get sectionPlannedToday => 'Planned Today';

  @override
  String get sectionLaterToday => 'Later Today & Evening';

  @override
  String get sectionCompletedToday => 'Completed';

  @override
  String get sortByPriority => 'By priority';

  @override
  String get sortByTime => 'By time';

  @override
  String labelCompletedAt(String time) {
    return 'Completed $time';
  }

  @override
  String get hintSwipeToAct => 'Swipe to act';

  @override
  String get emptyTodayTitle => 'All clear for today!';

  @override
  String emptyTodayMessage(int count) {
    return 'You completed $count tasks. Time to unwind, breathe deeply, and enjoy your evening.';
  }

  @override
  String get statCompleted => 'Completed';

  @override
  String get statDeepFocus => 'Deep Focus';

  @override
  String get statStreak => 'Streak';

  @override
  String statStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Days',
      one: '1 Day',
    );
    return '$_temp0';
  }

  @override
  String get digitalTwilightTitle => 'Digital Twilight';

  @override
  String digitalTwilightMessage(String time) {
    return 'Notifications silenced until $time';
  }

  @override
  String get upcomingTitle => 'Upcoming';

  @override
  String get upcomingSubtitle => 'Plan ahead';

  @override
  String get momentumTitle => 'Weekly Momentum';

  @override
  String momentumScheduled(int percent) {
    return '$percent% Scheduled';
  }

  @override
  String get labelTomorrow => 'Tomorrow';

  @override
  String get labelToday => 'Today';

  @override
  String tasksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks',
      one: '1 task',
      zero: 'No tasks',
    );
    return '$_temp0';
  }

  @override
  String get weekendLabel => 'Weekend';

  @override
  String get emptyDayTitle => 'No tasks scheduled — enjoy your day!';

  @override
  String get labelRecurringWeekly => 'Recurring weekly';

  @override
  String itemsInChecklist(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items in checklist',
      one: '1 item in checklist',
    );
    return '$_temp0';
  }

  @override
  String get weekendMessage => 'No tasks scheduled — enjoy your weekend!';

  @override
  String get listsTitle => 'Lists';

  @override
  String get listsSubtitle =>
      'Organise your sustained momentum and daily focus areas with clear intent.';

  @override
  String projectsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Projects',
      one: '1 Project',
    );
    return '$_temp0';
  }

  @override
  String get labelProjects => 'Projects';

  @override
  String get labelActiveTasks => 'Active Tasks';

  @override
  String get labelWeeklyVelocity => 'Weekly Velocity';

  @override
  String activeTasksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Active Tasks',
      one: '1 Active Task',
    );
    return '$_temp0';
  }

  @override
  String weeklyVelocity(int percent) {
    return '$percent% Weekly Velocity';
  }

  @override
  String tasksRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks remaining',
      one: '1 task remaining',
      zero: 'All done',
    );
    return '$_temp0';
  }

  @override
  String get labelProgress => 'Progress';

  @override
  String labelPercent(int percent) {
    return '$percent%';
  }

  @override
  String get labelAlmostThere => 'Almost there';

  @override
  String get newProjectTitle => 'New Project';

  @override
  String get newProjectSubtitle => 'Create custom list';

  @override
  String get dailyMilestoneTitle => 'Daily Milestone Momentum';

  @override
  String dailyMilestoneSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks finished across all lists',
      one: '1 task finished across all lists',
    );
    return '$_temp0';
  }

  @override
  String labelXpEarned(int xp) {
    return '+$xp XP';
  }

  @override
  String get tagHigh => 'High';

  @override
  String get tagRoutine => 'Routine';

  @override
  String get tagPriority => 'Priority';

  @override
  String get emptyListTitle => 'Nothing here yet';

  @override
  String get emptyListMessage =>
      'Add your first task to start building momentum.';

  @override
  String get taskDetailTitle => 'Task Details';

  @override
  String get labelTapToEdit => 'Tap to edit';

  @override
  String labelCreatedAt(String time) {
    return 'Created $time';
  }

  @override
  String get sectionNotes => 'Notes & Brief';

  @override
  String get sectionSubtasks => 'Subtasks';

  @override
  String subtasksProgress(int done, int total) {
    return '$done of $total done';
  }

  @override
  String get labelDueDateTime => 'Due Date & Time';

  @override
  String get labelNoDueDate => 'No due date';

  @override
  String labelDueIn(String time) {
    return 'Due in $time';
  }

  @override
  String labelOverdueBy(String time) {
    return 'Overdue by $time';
  }

  @override
  String get labelRecurrence => 'Recurrence';

  @override
  String get recurrenceNone => 'Does not repeat';

  @override
  String get repeatDaily => 'Every day';

  @override
  String get repeatWeekly => 'Every week';

  @override
  String get repeatMonthly => 'Every month';

  @override
  String get labelProjectList => 'Project List';

  @override
  String get labelTaskReminder => 'Task Reminder';

  @override
  String get reminderOff => 'Off';

  @override
  String get reminderAtDueTime => 'At due time';

  @override
  String reminderMinutesBefore(int minutes) {
    return '$minutes minutes before due';
  }

  @override
  String get taskDeleted => 'Task deleted';

  @override
  String get taskCompleted => 'Task completed';

  @override
  String get taskMovedToTomorrow => 'Moved to tomorrow';

  @override
  String get labelDueSchedule => 'Due schedule';

  @override
  String get scheduleToday => 'Today';

  @override
  String get scheduleTomorrow => 'Tomorrow';

  @override
  String get scheduleNextWeek => 'Next week';

  @override
  String get schedulePickDate => 'Pick a date';

  @override
  String get labelTaskMetadata => 'Task metadata';

  @override
  String get labelPriority => 'Priority';

  @override
  String get priorityNone => 'No priority';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityHigh => 'High';

  @override
  String get labelList => 'List';

  @override
  String get addTaskHint => 'What do you want to do?';

  @override
  String get labelNotes => 'Notes';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle => 'Your daily achievement';

  @override
  String get settingsGeneralTitle => 'General';

  @override
  String get settingsGeneralSubtitle => 'Theme, motion and haptics';

  @override
  String get settingsNotificationsSubtitle =>
      'Daily briefing and home-screen widgets';

  @override
  String get settingsDataSubtitle => 'Google Calendar, exports and history';

  @override
  String get settingsAboutTitle => 'About';

  @override
  String get settingsAboutSubtitle => 'Version, licences and credits';

  @override
  String settingsAboutSummary(String version) {
    return 'Anjiz v$version';
  }

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsOther => 'Other';

  @override
  String get settingsBrightness => 'Brightness';

  @override
  String get settingsColour => 'Colour';

  @override
  String get settingsMotion => 'Motion';

  @override
  String get settingsCalendar => 'Calendar';

  @override
  String get settingsExport => 'Export';

  @override
  String get settingsLegal => 'Legal';

  @override
  String get settingsNotificationsOn => 'Daily briefing on';

  @override
  String get settingsNotificationsOff => 'Daily briefing off';

  @override
  String get settingsPureBlackUnavailable => 'Available in dark mode';

  @override
  String get aboutLicences => 'Open-source licences';

  @override
  String get aboutLicencesSubtitle => 'Flutter, Drift and other dependencies';

  @override
  String get themeSettingsTitle => 'Theme';

  @override
  String get themeSettingsSubtitle => 'Mode, accent tone and dynamic colour';

  @override
  String get motionSettingsTitle => 'Motion & haptics';

  @override
  String get motionSettingsSubtitle => 'Spring animations and tactile feedback';

  @override
  String get profileTitle => 'Your profile';

  @override
  String get profileSubtitle => 'Name, photo and contact details';

  @override
  String get profileEditAction => 'Edit profile';

  @override
  String get profileNameMissing => 'Add your name';

  @override
  String get profileLocalOnly => 'Saved on this device';

  @override
  String get profileLocalTag => 'On this device';

  @override
  String get profilePhotoTitle => 'Profile photo';

  @override
  String get profileTakePhoto => 'Take a photo';

  @override
  String get profileChooseFromGallery => 'Choose from gallery';

  @override
  String get profileRemovePhoto => 'Remove photo';

  @override
  String get profileSaved => 'Profile saved';

  @override
  String get labelName => 'Name';

  @override
  String get hintName => 'Your name';

  @override
  String get labelEmail => 'Email';

  @override
  String get hintEmail => 'you@example.com';

  @override
  String labelLastSynced(String time) {
    return 'Last synced $time ago';
  }

  @override
  String get appearanceTitle => 'Appearance & Theme';

  @override
  String get tagMaterialYou => 'Material You';

  @override
  String get labelDynamicColor => 'Dynamic Color';

  @override
  String get dynamicColorSubtitle =>
      'Harmonise UI colours with your wallpaper palette';

  @override
  String get labelThemeMode => 'Theme mode';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get labelPureBlack => 'Pure black (OLED)';

  @override
  String get pureBlackSubtitle => 'Use true black surfaces in dark mode';

  @override
  String get labelAccentTone => 'Accent tone';

  @override
  String get accentEmerald => 'Emerald';

  @override
  String get accentOcean => 'Ocean';

  @override
  String get accentIndigo => 'Indigo';

  @override
  String get accentViolet => 'Violet';

  @override
  String get accentRose => 'Rose';

  @override
  String get accentTerracotta => 'Terracotta';

  @override
  String get accentAmber => 'Amber';

  @override
  String get accentTeal => 'Teal';

  @override
  String get accentLavender => 'Lavender';

  @override
  String get accentSand => 'Sand';

  @override
  String get shapeMotionTitle => 'Shape & Expressive Motion';

  @override
  String get labelBurstAnimations => 'Scalloped Burst Animations';

  @override
  String get burstAnimationsSubtitle =>
      'Kinetic confetti & organic bursts upon task achievement';

  @override
  String get tagDelight => 'Delight';

  @override
  String get labelSpringHaptics => 'Spring Haptics';

  @override
  String get springHapticsSubtitle => 'Biometric tactile feedback intensity';

  @override
  String get hapticOff => 'Off';

  @override
  String get hapticSubtle => 'Subtle';

  @override
  String get hapticExpressive => 'Expressive';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsAndWidgetsTitle => 'Notifications & Widgets';

  @override
  String get labelDailyBriefing => 'Daily Briefing';

  @override
  String get dailyBriefingSubtitle =>
      'Morning summary of prioritised tasks & milestones';

  @override
  String get dailyBriefingNotificationBody =>
      'Here\'s your plan for today. Open Anjiz to get started.';

  @override
  String get labelWidgetConfig => 'Widget Configuration & Previews';

  @override
  String get widgetConfigSubtitle => 'List, completed tasks and opacity';

  @override
  String get dataTitle => 'Data & Backup';

  @override
  String get dataCalendarNotConnected => 'Not connected';

  @override
  String get labelGoogleCalendar => 'Google Calendar';

  @override
  String get labelExportTasks => 'Export Tasks & History';

  @override
  String get exportJson => 'JSON';

  @override
  String get exportMarkdown => 'MD';

  @override
  String get exportCsv => 'CSV';

  @override
  String get exportStarted => 'Export started';

  @override
  String footerVersion(String version) {
    return 'Anjiz v$version Expressive • Built with Material 3';
  }

  @override
  String get footerTagline => 'Made with love to support daily achievement';

  @override
  String get widgetConfigTitle => 'Widgets';

  @override
  String get widgetOverviewTitle => 'Tasks Overview';

  @override
  String get widgetOverviewSubtitle =>
      'List switcher, quick add and up to six tasks';

  @override
  String get widgetCompactTitle => 'Compact';

  @override
  String get widgetCompactSubtitle => 'Your next three tasks at a glance';

  @override
  String get widgetProgressTitle => 'Progress';

  @override
  String get widgetProgressSubtitle => 'A wavy ring of today\'s done/total';

  @override
  String get widgetQuickAddTitle => 'Quick add';

  @override
  String get widgetQuickAddSubtitle => 'Capture a task in one tap';

  @override
  String get widgetConfigListLabel => 'Choose list';

  @override
  String get widgetConfigShowCompleted => 'Show completed';

  @override
  String get widgetConfigOpacity => 'Opacity';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingTitle1 => 'Welcome to Anjiz';

  @override
  String get onboardingMessage1 =>
      'An offline-first task manager built around calm, focused momentum.';

  @override
  String get onboardingTitle2 => 'Expressive by default';

  @override
  String get onboardingMessage2 =>
      'Scalloped checkboxes, springy motion and Material You colour throughout.';

  @override
  String get onboardingTitle3 => 'Always within reach';

  @override
  String get onboardingMessage3 =>
      'Home-screen widgets keep your day visible without opening the app.';

  @override
  String get onboardingProfileTitle => 'Set up your profile';

  @override
  String get onboardingProfileMessage =>
      'Your name and photo stay on this device and personalise the app.';

  @override
  String get onboardingPermissionsTitle => 'Stay on track';

  @override
  String get onboardingPermissionsMessage =>
      'Allow reminders so Anjiz can nudge you at the right moment. You can change this later.';

  @override
  String get onboardingPermissionNotifications =>
      'Reminders and the daily briefing';

  @override
  String get onboardingExactAlarmTitle => 'Exact reminders';

  @override
  String get onboardingPermissionExactAlarms =>
      'Nudge you at the precise minute';

  @override
  String get labelUntimed => 'Untimed';

  @override
  String get labelListName => 'List name';

  @override
  String get labelListColor => 'Accent colour';

  @override
  String get labelListIcon => 'Icon';

  @override
  String get actionCreateList => 'Create list';

  @override
  String get actionDeleteList => 'Delete list';

  @override
  String get momentumEmptyMessage =>
      'Nothing scheduled yet — add a task to build momentum.';

  @override
  String get previewLabel => 'Preview';

  @override
  String get widgetConfigSaved => 'Widget settings saved';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get updateTitle => 'App update';

  @override
  String get updateSubtitle => 'Newer releases install right over this one';

  @override
  String updateInstalledVersion(String version) {
    return 'Installed v$version';
  }

  @override
  String updateLatestVersion(String version) {
    return 'Latest v$version';
  }

  @override
  String updateCurrentSummary(String version) {
    return 'Anjiz v$version · Up to date';
  }

  @override
  String updateAvailableSummary(String version) {
    return 'Version $version is ready';
  }

  @override
  String get updateDownloading => 'Downloading…';

  @override
  String get updateInstalling => 'Installing…';

  @override
  String get updateChecking => 'Checking…';

  @override
  String get updateCheckingBody => 'Looking for a newer release.';

  @override
  String get updateCheckFailed => 'Couldn\'t check for updates';

  @override
  String get updateCurrentTitle => 'You\'re up to date';

  @override
  String get updateCurrentBody => 'This is the newest release of Anjiz.';

  @override
  String updateAvailableTitle(String version) {
    return 'Version $version is available';
  }

  @override
  String get updateAvailableBody =>
      'The update downloads in the app and installs over this one.';

  @override
  String get updateWhatsNew => 'What\'s new';

  @override
  String get updateCheckAction => 'Check for updates';

  @override
  String get updateCheckAgainAction => 'Check again';

  @override
  String get updateInstallAction => 'Download and install';

  @override
  String get updateRetryAction => 'Try again';

  @override
  String updateDownloadingLabel(int percent) {
    return 'Downloading… $percent%';
  }

  @override
  String get updateInstallingTitle => 'Finishing in Android';

  @override
  String get updateInstallingBody =>
      'Follow the installer on screen to complete the update.';

  @override
  String get updateInstallHint =>
      'Android asks once to allow Anjiz to install apps.';

  @override
  String get updateErrorNetwork =>
      'Couldn\'t reach the release server. Check your connection and try again.';

  @override
  String get updateErrorMalformed =>
      'The release information couldn\'t be read. Try again later.';

  @override
  String get updateErrorUnsupported =>
      'In-app updates are available on Android.';

  @override
  String get updateErrorPermission =>
      'Allow Anjiz to install unknown apps in Android settings, then try again.';

  @override
  String get updateErrorChecksum =>
      'The download didn\'t match the published file, so it was discarded.';

  @override
  String get updateErrorDownload => 'The download failed. Try again.';

  @override
  String get updateErrorInstall => 'Android refused the update. Try again.';

  @override
  String get updateErrorCancelled => 'The download was cancelled.';

  @override
  String get updateErrorUnknown =>
      'Something went wrong. Try again in a moment.';

  @override
  String get updateNotificationTitle => 'Anjiz update available';

  @override
  String updateNotificationBody(String version) {
    return 'Version $version is ready to download.';
  }

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorMessage => 'Please try again in a moment.';

  @override
  String get errorDatabaseMessage => 'We couldn\'t read your tasks.';

  @override
  String get errorNotificationMessage => 'We couldn\'t schedule that reminder.';

  @override
  String get errorWidgetMessage =>
      'We couldn\'t refresh the home-screen widget.';

  @override
  String get errorValidationMessage => 'Please check the highlighted fields.';

  @override
  String get defaultListName => 'My Tasks';

  @override
  String get myDay => 'My day';

  @override
  String get labelDays => 'day';

  @override
  String durationMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String durationHours(int hours) {
    return '${hours}h';
  }

  @override
  String durationDays(int days) {
    return '${days}d';
  }

  @override
  String get themePreviewTitle => 'Button & Component Preview';

  @override
  String get themePreviewSubtitle =>
      'Live preview of buttons and controls in this palette';

  @override
  String get themeButtonPrimary => 'Primary Action';

  @override
  String get themeButtonTonal => 'Tonal Button';

  @override
  String get themeButtonOutlined => 'Outlined';

  @override
  String get themeChipTask => 'High Priority';

  @override
  String get notificationsTestTitle => 'Test Notification Delivery';

  @override
  String get notificationsTestSubtitle =>
      'Send an instant test notification to check channel, vibration, and banner';

  @override
  String get notificationsSendTest => 'Send test notification';

  @override
  String get notificationsTestSent =>
      'Test notification delivered! Check your shade.';

  @override
  String get notificationsPermissionTitle => 'Notification Permission';

  @override
  String get notificationsPermissionSubtitle =>
      'Required for task reminders and daily briefings';

  @override
  String get notificationsPermissionGranted => 'Permission granted';

  @override
  String get notificationsPermissionDenied => 'Permission not granted';

  @override
  String get notificationsGrantAction => 'Grant permission';

  @override
  String get notificationsChannelActive =>
      'Android notification channels verified active';

  @override
  String get motionPlaygroundTitle => 'Interactive Motion Playground';

  @override
  String get motionPlaygroundSubtitle =>
      'Tap the checkbox below to test the spring morphing, bursts and tactile haptics live';

  @override
  String get motionDemoTask => 'Review priority tasks for today';

  @override
  String get motionDemoSubtitle =>
      'Tap the scalloped cookie checkbox to feel and see the motion';

  @override
  String get motionTestHaptics => 'Tap to test current haptic strength';

  @override
  String get aboutAppDescription =>
      'An offline-first, Material 3 Expressive task manager built for intentional daily achievement, spring physics, and Android home-screen widgets.';

  @override
  String get aboutSourceCode => 'Source Code';

  @override
  String get aboutAuthor => 'Crafted with passion by Abdo Gouhmad';

  @override
  String get aboutHighlightsTitle => 'Architecture Highlights';

  @override
  String get aboutHighlightOffline =>
      'Offline-first with SQLite (Drift) single source of truth';

  @override
  String get aboutHighlightExpressive =>
      'Material 3 Expressive spring physics & custom shapes';

  @override
  String get aboutHighlightWidgets =>
      'Native Android Glance home-screen widgets';

  @override
  String get updateUpToDate => 'You are up to date';

  @override
  String get updateAvailableBadge => 'New update available';

  @override
  String get updateDetailsTitle => 'Version details';

  @override
  String get updateCurrentVersionLabel => 'Current version';

  @override
  String get updateLatestVersionLabel => 'Latest version';

  @override
  String get updateInstallType => 'Install type';

  @override
  String get updateInstallTypeValue => 'Universal APK';

  @override
  String get updateLastChecked => 'Last checked';

  @override
  String get updateLastResult => 'Last result';

  @override
  String get updateJustNow => 'Just now';

  @override
  String updateMinutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String updateHoursAgo(int hours) {
    return '$hours h ago';
  }

  @override
  String get updateNever => 'Never';

  @override
  String get updateReadyInstallTitle => 'Update verified & ready to install';
}

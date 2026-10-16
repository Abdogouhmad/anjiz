import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Anjiz'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Achieve today'**
  String get appTagline;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get navUpcoming;

  /// No description provided for @navLists.
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get navLists;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @actionNewTask.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get actionNewTask;

  /// No description provided for @actionAddTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get actionAddTask;

  /// No description provided for @actionAddAnother.
  ///
  /// In en, this message translates to:
  /// **'Add Another'**
  String get actionAddAnother;

  /// No description provided for @actionAddSubtask.
  ///
  /// In en, this message translates to:
  /// **'Add subtask'**
  String get actionAddSubtask;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get actionDone;

  /// No description provided for @actionUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get actionUndo;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @actionChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get actionChange;

  /// No description provided for @actionClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get actionClear;

  /// No description provided for @actionClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// No description provided for @actionSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionSkip;

  /// No description provided for @actionNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get actionNext;

  /// No description provided for @actionGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get actionGetStarted;

  /// No description provided for @actionMarkComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark Complete'**
  String get actionMarkComplete;

  /// No description provided for @actionShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get actionShare;

  /// No description provided for @actionSnooze.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get actionSnooze;

  /// No description provided for @actionAddVoiceNote.
  ///
  /// In en, this message translates to:
  /// **'Voice note'**
  String get actionAddVoiceNote;

  /// No description provided for @actionNewList.
  ///
  /// In en, this message translates to:
  /// **'New List'**
  String get actionNewList;

  /// No description provided for @actionRescheduleAll.
  ///
  /// In en, this message translates to:
  /// **'Reschedule all'**
  String get actionRescheduleAll;

  /// No description provided for @actionPlanTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Plan Tomorrow'**
  String get actionPlanTomorrow;

  /// No description provided for @actionReviewCompleted.
  ///
  /// In en, this message translates to:
  /// **'Review Completed Tasks'**
  String get actionReviewCompleted;

  /// No description provided for @actionFullCalendar.
  ///
  /// In en, this message translates to:
  /// **'Full Calendar'**
  String get actionFullCalendar;

  /// No description provided for @actionManagePlan.
  ///
  /// In en, this message translates to:
  /// **'Manage Plan'**
  String get actionManagePlan;

  /// No description provided for @actionOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get actionOptions;

  /// No description provided for @actionExpandMenu.
  ///
  /// In en, this message translates to:
  /// **'Show more actions'**
  String get actionExpandMenu;

  /// No description provided for @actionCollapseMenu.
  ///
  /// In en, this message translates to:
  /// **'Hide actions'**
  String get actionCollapseMenu;

  /// No description provided for @actionStarTask.
  ///
  /// In en, this message translates to:
  /// **'Star task'**
  String get actionStarTask;

  /// No description provided for @actionUnstarTask.
  ///
  /// In en, this message translates to:
  /// **'Unstar task'**
  String get actionUnstarTask;

  /// No description provided for @actionCompleteTask.
  ///
  /// In en, this message translates to:
  /// **'Complete {title}'**
  String actionCompleteTask(String title);

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search tasks'**
  String get searchHint;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @searchEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get searchEmptyTitle;

  /// No description provided for @searchEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Try a different word or check another list.'**
  String get searchEmptyMessage;

  /// No description provided for @searchPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Find anything'**
  String get searchPromptTitle;

  /// No description provided for @searchPromptMessage.
  ///
  /// In en, this message translates to:
  /// **'Search across every task by title or note.'**
  String get searchPromptMessage;

  /// No description provided for @todaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Achieve today'**
  String get todaySubtitle;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning!'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon!'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening!'**
  String get greetingEvening;

  /// No description provided for @todaySummary.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Nothing left for a peaceful evening.} =1{1 task left for a peaceful evening.} other{{count} tasks left for a peaceful evening.}}'**
  String todaySummary(int count);

  /// No description provided for @sectionOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get sectionOverdue;

  /// No description provided for @sectionPlannedToday.
  ///
  /// In en, this message translates to:
  /// **'Planned Today'**
  String get sectionPlannedToday;

  /// No description provided for @sectionLaterToday.
  ///
  /// In en, this message translates to:
  /// **'Later Today & Evening'**
  String get sectionLaterToday;

  /// No description provided for @sectionCompletedToday.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get sectionCompletedToday;

  /// No description provided for @sortByPriority.
  ///
  /// In en, this message translates to:
  /// **'By priority'**
  String get sortByPriority;

  /// No description provided for @labelCompletedAt.
  ///
  /// In en, this message translates to:
  /// **'Completed {time}'**
  String labelCompletedAt(String time);

  /// No description provided for @hintSwipeToAct.
  ///
  /// In en, this message translates to:
  /// **'Swipe to act'**
  String get hintSwipeToAct;

  /// No description provided for @emptyTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'All clear for today!'**
  String get emptyTodayTitle;

  /// No description provided for @emptyTodayMessage.
  ///
  /// In en, this message translates to:
  /// **'You completed {count} tasks. Time to unwind, breathe deeply, and enjoy your evening.'**
  String emptyTodayMessage(int count);

  /// No description provided for @statCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statCompleted;

  /// No description provided for @statDeepFocus.
  ///
  /// In en, this message translates to:
  /// **'Deep Focus'**
  String get statDeepFocus;

  /// No description provided for @statStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get statStreak;

  /// No description provided for @statStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Day} other{{count} Days}}'**
  String statStreakDays(int count);

  /// No description provided for @digitalTwilightTitle.
  ///
  /// In en, this message translates to:
  /// **'Digital Twilight'**
  String get digitalTwilightTitle;

  /// No description provided for @digitalTwilightMessage.
  ///
  /// In en, this message translates to:
  /// **'Notifications silenced until {time}'**
  String digitalTwilightMessage(String time);

  /// No description provided for @upcomingTitle.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcomingTitle;

  /// No description provided for @upcomingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plan ahead'**
  String get upcomingSubtitle;

  /// No description provided for @momentumTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Momentum'**
  String get momentumTitle;

  /// No description provided for @momentumScheduled.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Scheduled'**
  String momentumScheduled(int percent);

  /// No description provided for @labelTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get labelTomorrow;

  /// No description provided for @labelToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get labelToday;

  /// No description provided for @tasksCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No tasks} =1{1 task} other{{count} tasks}}'**
  String tasksCount(int count);

  /// No description provided for @weekendLabel.
  ///
  /// In en, this message translates to:
  /// **'Weekend'**
  String get weekendLabel;

  /// No description provided for @emptyDayTitle.
  ///
  /// In en, this message translates to:
  /// **'No tasks scheduled — enjoy your day!'**
  String get emptyDayTitle;

  /// No description provided for @labelRecurringWeekly.
  ///
  /// In en, this message translates to:
  /// **'Recurring weekly'**
  String get labelRecurringWeekly;

  /// No description provided for @itemsInChecklist.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item in checklist} other{{count} items in checklist}}'**
  String itemsInChecklist(int count);

  /// No description provided for @weekendMessage.
  ///
  /// In en, this message translates to:
  /// **'No tasks scheduled — enjoy your weekend!'**
  String get weekendMessage;

  /// No description provided for @listsTitle.
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get listsTitle;

  /// No description provided for @listsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Organise your sustained momentum and daily focus areas with clear intent.'**
  String get listsSubtitle;

  /// No description provided for @projectsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Project} other{{count} Projects}}'**
  String projectsCount(int count);

  /// No description provided for @labelProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get labelProjects;

  /// No description provided for @labelActiveTasks.
  ///
  /// In en, this message translates to:
  /// **'Active Tasks'**
  String get labelActiveTasks;

  /// No description provided for @labelWeeklyVelocity.
  ///
  /// In en, this message translates to:
  /// **'Weekly Velocity'**
  String get labelWeeklyVelocity;

  /// No description provided for @activeTasksCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Active Task} other{{count} Active Tasks}}'**
  String activeTasksCount(int count);

  /// No description provided for @weeklyVelocity.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Weekly Velocity'**
  String weeklyVelocity(int percent);

  /// No description provided for @tasksRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{All done} =1{1 task remaining} other{{count} tasks remaining}}'**
  String tasksRemaining(int count);

  /// No description provided for @labelProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get labelProgress;

  /// No description provided for @labelPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String labelPercent(int percent);

  /// No description provided for @labelAlmostThere.
  ///
  /// In en, this message translates to:
  /// **'Almost there'**
  String get labelAlmostThere;

  /// No description provided for @newProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'New Project'**
  String get newProjectTitle;

  /// No description provided for @newProjectSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create custom list'**
  String get newProjectSubtitle;

  /// No description provided for @dailyMilestoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Milestone Momentum'**
  String get dailyMilestoneTitle;

  /// No description provided for @dailyMilestoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 task finished across all lists} other{{count} tasks finished across all lists}}'**
  String dailyMilestoneSubtitle(int count);

  /// No description provided for @labelXpEarned.
  ///
  /// In en, this message translates to:
  /// **'+{xp} XP'**
  String labelXpEarned(int xp);

  /// No description provided for @tagHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get tagHigh;

  /// No description provided for @tagRoutine.
  ///
  /// In en, this message translates to:
  /// **'Routine'**
  String get tagRoutine;

  /// No description provided for @tagPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get tagPriority;

  /// No description provided for @emptyListTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get emptyListTitle;

  /// No description provided for @emptyListMessage.
  ///
  /// In en, this message translates to:
  /// **'Add your first task to start building momentum.'**
  String get emptyListMessage;

  /// No description provided for @taskDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get taskDetailTitle;

  /// No description provided for @labelTapToEdit.
  ///
  /// In en, this message translates to:
  /// **'Tap to edit'**
  String get labelTapToEdit;

  /// No description provided for @labelCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Created {time}'**
  String labelCreatedAt(String time);

  /// No description provided for @sectionNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes & Brief'**
  String get sectionNotes;

  /// No description provided for @sectionSubtasks.
  ///
  /// In en, this message translates to:
  /// **'Subtasks'**
  String get sectionSubtasks;

  /// No description provided for @subtasksProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} done'**
  String subtasksProgress(int done, int total);

  /// No description provided for @labelDueDateTime.
  ///
  /// In en, this message translates to:
  /// **'Due Date & Time'**
  String get labelDueDateTime;

  /// No description provided for @labelNoDueDate.
  ///
  /// In en, this message translates to:
  /// **'No due date'**
  String get labelNoDueDate;

  /// No description provided for @labelDueIn.
  ///
  /// In en, this message translates to:
  /// **'Due in {time}'**
  String labelDueIn(String time);

  /// No description provided for @labelOverdueBy.
  ///
  /// In en, this message translates to:
  /// **'Overdue by {time}'**
  String labelOverdueBy(String time);

  /// No description provided for @labelRecurrence.
  ///
  /// In en, this message translates to:
  /// **'Recurrence'**
  String get labelRecurrence;

  /// No description provided for @recurrenceNone.
  ///
  /// In en, this message translates to:
  /// **'Does not repeat'**
  String get recurrenceNone;

  /// No description provided for @repeatDaily.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In en, this message translates to:
  /// **'Every week'**
  String get repeatWeekly;

  /// No description provided for @repeatMonthly.
  ///
  /// In en, this message translates to:
  /// **'Every month'**
  String get repeatMonthly;

  /// No description provided for @labelProjectList.
  ///
  /// In en, this message translates to:
  /// **'Project List'**
  String get labelProjectList;

  /// No description provided for @labelTaskReminder.
  ///
  /// In en, this message translates to:
  /// **'Task Reminder'**
  String get labelTaskReminder;

  /// No description provided for @reminderOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get reminderOff;

  /// No description provided for @reminderAtDueTime.
  ///
  /// In en, this message translates to:
  /// **'At due time'**
  String get reminderAtDueTime;

  /// No description provided for @reminderMinutesBefore.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes before due'**
  String reminderMinutesBefore(int minutes);

  /// No description provided for @taskDeleted.
  ///
  /// In en, this message translates to:
  /// **'Task deleted'**
  String get taskDeleted;

  /// No description provided for @taskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Task completed'**
  String get taskCompleted;

  /// No description provided for @taskMovedToTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Moved to tomorrow'**
  String get taskMovedToTomorrow;

  /// No description provided for @labelDueSchedule.
  ///
  /// In en, this message translates to:
  /// **'Due schedule'**
  String get labelDueSchedule;

  /// No description provided for @scheduleToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get scheduleToday;

  /// No description provided for @scheduleTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get scheduleTomorrow;

  /// No description provided for @scheduleNextWeek.
  ///
  /// In en, this message translates to:
  /// **'Next week'**
  String get scheduleNextWeek;

  /// No description provided for @schedulePickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get schedulePickDate;

  /// No description provided for @labelTaskMetadata.
  ///
  /// In en, this message translates to:
  /// **'Task metadata'**
  String get labelTaskMetadata;

  /// No description provided for @labelPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get labelPriority;

  /// No description provided for @priorityNone.
  ///
  /// In en, this message translates to:
  /// **'No priority'**
  String get priorityNone;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// No description provided for @priorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get priorityMedium;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// No description provided for @labelList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get labelList;

  /// No description provided for @addTaskHint.
  ///
  /// In en, this message translates to:
  /// **'What do you want to do?'**
  String get addTaskHint;

  /// No description provided for @labelNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get labelNotes;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'إنجاز اليوم'**
  String get settingsSubtitle;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Sarah Al-Mansoor'**
  String get profileName;

  /// No description provided for @profileEmail.
  ///
  /// In en, this message translates to:
  /// **'sarah.mansoor@example.com'**
  String get profileEmail;

  /// No description provided for @proSyncActive.
  ///
  /// In en, this message translates to:
  /// **'Pro Sync Active'**
  String get proSyncActive;

  /// No description provided for @labelLastSynced.
  ///
  /// In en, this message translates to:
  /// **'Last synced {time} ago'**
  String labelLastSynced(String time);

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance & Theme'**
  String get appearanceTitle;

  /// No description provided for @tagMaterialYou.
  ///
  /// In en, this message translates to:
  /// **'Material You'**
  String get tagMaterialYou;

  /// No description provided for @labelDynamicColor.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Color'**
  String get labelDynamicColor;

  /// No description provided for @dynamicColorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Harmonise UI colours with your wallpaper palette'**
  String get dynamicColorSubtitle;

  /// No description provided for @labelThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get labelThemeMode;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @labelAccentTone.
  ///
  /// In en, this message translates to:
  /// **'Accent tone'**
  String get labelAccentTone;

  /// No description provided for @accentEmerald.
  ///
  /// In en, this message translates to:
  /// **'Emerald'**
  String get accentEmerald;

  /// No description provided for @accentOcean.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get accentOcean;

  /// No description provided for @accentTerracotta.
  ///
  /// In en, this message translates to:
  /// **'Terracotta'**
  String get accentTerracotta;

  /// No description provided for @accentLavender.
  ///
  /// In en, this message translates to:
  /// **'Lavender'**
  String get accentLavender;

  /// No description provided for @accentSand.
  ///
  /// In en, this message translates to:
  /// **'Sand'**
  String get accentSand;

  /// No description provided for @shapeMotionTitle.
  ///
  /// In en, this message translates to:
  /// **'Shape & Expressive Motion'**
  String get shapeMotionTitle;

  /// No description provided for @labelBurstAnimations.
  ///
  /// In en, this message translates to:
  /// **'Scalloped Burst Animations'**
  String get labelBurstAnimations;

  /// No description provided for @burstAnimationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Kinetic confetti & organic bursts upon task achievement'**
  String get burstAnimationsSubtitle;

  /// No description provided for @tagDelight.
  ///
  /// In en, this message translates to:
  /// **'Delight'**
  String get tagDelight;

  /// No description provided for @labelSpringHaptics.
  ///
  /// In en, this message translates to:
  /// **'Spring Haptics'**
  String get labelSpringHaptics;

  /// No description provided for @springHapticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric tactile feedback intensity'**
  String get springHapticsSubtitle;

  /// No description provided for @hapticOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get hapticOff;

  /// No description provided for @hapticSubtle.
  ///
  /// In en, this message translates to:
  /// **'Subtle'**
  String get hapticSubtle;

  /// No description provided for @hapticExpressive.
  ///
  /// In en, this message translates to:
  /// **'Expressive'**
  String get hapticExpressive;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications & Widgets'**
  String get notificationsTitle;

  /// No description provided for @labelDailyBriefing.
  ///
  /// In en, this message translates to:
  /// **'Daily Briefing'**
  String get labelDailyBriefing;

  /// No description provided for @dailyBriefingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Morning summary of prioritised tasks & milestones'**
  String get dailyBriefingSubtitle;

  /// No description provided for @labelWidgetConfig.
  ///
  /// In en, this message translates to:
  /// **'Widget Configuration & Previews'**
  String get labelWidgetConfig;

  /// No description provided for @widgetConfigSubtitle.
  ///
  /// In en, this message translates to:
  /// **'HomeScreen glances, Quick-add pill, lock-screen ticker'**
  String get widgetConfigSubtitle;

  /// No description provided for @dataTitle.
  ///
  /// In en, this message translates to:
  /// **'Data & Backup'**
  String get dataTitle;

  /// No description provided for @labelGoogleCalendar.
  ///
  /// In en, this message translates to:
  /// **'Google Calendar'**
  String get labelGoogleCalendar;

  /// No description provided for @calendarConnectedAs.
  ///
  /// In en, this message translates to:
  /// **'Connected as {email}'**
  String calendarConnectedAs(String email);

  /// No description provided for @labelExportTasks.
  ///
  /// In en, this message translates to:
  /// **'Export Tasks & History'**
  String get labelExportTasks;

  /// No description provided for @exportJson.
  ///
  /// In en, this message translates to:
  /// **'JSON'**
  String get exportJson;

  /// No description provided for @exportMarkdown.
  ///
  /// In en, this message translates to:
  /// **'MD'**
  String get exportMarkdown;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'CSV'**
  String get exportCsv;

  /// No description provided for @exportStarted.
  ///
  /// In en, this message translates to:
  /// **'Export started'**
  String get exportStarted;

  /// No description provided for @footerVersion.
  ///
  /// In en, this message translates to:
  /// **'Anjiz v{version} Expressive • Built with Material 3'**
  String footerVersion(String version);

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'Made with love to support daily achievement'**
  String get footerTagline;

  /// No description provided for @widgetConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get widgetConfigTitle;

  /// No description provided for @widgetOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasks Overview'**
  String get widgetOverviewTitle;

  /// No description provided for @widgetOverviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'List switcher, quick add and up to six tasks'**
  String get widgetOverviewSubtitle;

  /// No description provided for @widgetCompactTitle.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get widgetCompactTitle;

  /// No description provided for @widgetCompactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your next three tasks at a glance'**
  String get widgetCompactSubtitle;

  /// No description provided for @widgetProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get widgetProgressTitle;

  /// No description provided for @widgetProgressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A wavy ring of today\'s done/total'**
  String get widgetProgressSubtitle;

  /// No description provided for @widgetQuickAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick add'**
  String get widgetQuickAddTitle;

  /// No description provided for @widgetQuickAddSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Capture a task in one tap'**
  String get widgetQuickAddSubtitle;

  /// No description provided for @widgetConfigListLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose list'**
  String get widgetConfigListLabel;

  /// No description provided for @widgetConfigShowCompleted.
  ///
  /// In en, this message translates to:
  /// **'Show completed'**
  String get widgetConfigShowCompleted;

  /// No description provided for @widgetConfigOpacity.
  ///
  /// In en, this message translates to:
  /// **'Opacity'**
  String get widgetConfigOpacity;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Anjiz'**
  String get onboardingTitle1;

  /// No description provided for @onboardingMessage1.
  ///
  /// In en, this message translates to:
  /// **'An offline-first task manager built around calm, focused momentum.'**
  String get onboardingMessage1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Expressive by default'**
  String get onboardingTitle2;

  /// No description provided for @onboardingMessage2.
  ///
  /// In en, this message translates to:
  /// **'Scalloped checkboxes, springy motion and Material You colour throughout.'**
  String get onboardingMessage2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Always within reach'**
  String get onboardingTitle3;

  /// No description provided for @onboardingMessage3.
  ///
  /// In en, this message translates to:
  /// **'Home-screen widgets keep your day visible without opening the app.'**
  String get onboardingMessage3;

  /// No description provided for @labelUntimed.
  ///
  /// In en, this message translates to:
  /// **'Untimed'**
  String get labelUntimed;

  /// No description provided for @labelListName.
  ///
  /// In en, this message translates to:
  /// **'List name'**
  String get labelListName;

  /// No description provided for @labelListColor.
  ///
  /// In en, this message translates to:
  /// **'Accent colour'**
  String get labelListColor;

  /// No description provided for @labelListIcon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get labelListIcon;

  /// No description provided for @actionCreateList.
  ///
  /// In en, this message translates to:
  /// **'Create list'**
  String get actionCreateList;

  /// No description provided for @actionDeleteList.
  ///
  /// In en, this message translates to:
  /// **'Delete list'**
  String get actionDeleteList;

  /// No description provided for @momentumEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing scheduled yet — add a task to build momentum.'**
  String get momentumEmptyMessage;

  /// No description provided for @previewLabel.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get previewLabel;

  /// No description provided for @widgetConfigSaved.
  ///
  /// In en, this message translates to:
  /// **'Widget settings saved'**
  String get widgetConfigSaved;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please try again in a moment.'**
  String get errorMessage;

  /// No description provided for @errorDatabaseMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read your tasks.'**
  String get errorDatabaseMessage;

  /// No description provided for @errorNotificationMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t schedule that reminder.'**
  String get errorNotificationMessage;

  /// No description provided for @errorWidgetMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t refresh the home-screen widget.'**
  String get errorWidgetMessage;

  /// No description provided for @errorValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Please check the highlighted fields.'**
  String get errorValidationMessage;

  /// No description provided for @defaultListName.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get defaultListName;

  /// No description provided for @myDay.
  ///
  /// In en, this message translates to:
  /// **'My day'**
  String get myDay;

  /// No description provided for @labelDays.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get labelDays;

  /// No description provided for @timeNow.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get timeNow;

  /// No description provided for @timeInMinutes.
  ///
  /// In en, this message translates to:
  /// **'in {minutes}m'**
  String timeInMinutes(int minutes);

  /// No description provided for @timeInHours.
  ///
  /// In en, this message translates to:
  /// **'in {hours}h'**
  String timeInHours(int hours);

  /// No description provided for @timeInDays.
  ///
  /// In en, this message translates to:
  /// **'in {days}d'**
  String timeInDays(int days);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

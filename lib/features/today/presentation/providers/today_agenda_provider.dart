import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/today_agenda.dart';
import '../../../../app/providers/use_case_providers.dart';

part 'today_agenda_provider.g.dart';

/// Streams the grouped agenda for the current day.
@riverpod
Stream<TodayAgenda> todayAgenda(Ref ref) {
  final watchToday = ref.watch(watchTodayTasksProvider);
  return watchToday(DateTime.now());
}

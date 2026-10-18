import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/upcoming_agenda.dart';
import '../../../../app/providers/use_case_providers.dart';

part 'upcoming_agenda_provider.g.dart';

/// Streams the seven-day upcoming agenda (starting tomorrow).
@riverpod
Stream<UpcomingAgenda> upcomingAgenda(Ref ref) {
  final watchUpcoming = ref.watch(watchUpcomingTasksProvider);
  return watchUpcoming(DateTime.now());
}

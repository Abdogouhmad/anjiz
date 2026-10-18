import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/subtask.dart';
import '../../../../app/providers/use_case_providers.dart';

part 'task_subtasks_provider.g.dart';

/// Streams the checklist items belonging to [taskId].
@riverpod
Stream<List<Subtask>> taskSubtasks(Ref ref, String taskId) =>
    ref.watch(watchSubtasksProvider).call(taskId);

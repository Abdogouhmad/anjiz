import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/repository_providers.dart';
import '../../../../domain/entities/task.dart';

part 'task_by_id_provider.g.dart';

/// Streams a single task by id, or `null` when it no longer exists.
@riverpod
Stream<Task?> taskById(Ref ref, String id) =>
    ref.watch(taskRepositoryProvider).watchAll().map<Task?>((tasks) {
      for (final task in tasks) {
        if (task.id == id) return task;
      }
      return null;
    });

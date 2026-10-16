import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/repository_providers.dart';
import '../../../../domain/entities/task.dart';

part 'search_providers.g.dart';

/// Holds the live search query typed into the search screen.
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  /// Replaces the query.
  void set(String value) => state = value;

  /// Clears the query.
  void clear() => state = '';
}

/// Streams the tasks matching the current query (empty when the query is blank).
@riverpod
Stream<List<Task>> searchResults(Ref ref) {
  final query = ref.watch(searchQueryProvider).trim();
  if (query.isEmpty) return Stream.value(const <Task>[]);
  return ref.watch(taskRepositoryProvider).watchSearch(query);
}

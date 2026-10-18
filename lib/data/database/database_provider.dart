import 'package:anjiz/data/database/anjiz_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

/// Provides the single [AnjizDatabase] instance for the application lifetime.
@Riverpod(keepAlive: true)
AnjizDatabase database(Ref ref) {
  final database = AnjizDatabase();
  ref.onDispose(database.close);
  return database;
}

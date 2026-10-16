// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_agenda_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Streams the grouped agenda for the current day.

@ProviderFor(todayAgenda)
final todayAgendaProvider = TodayAgendaProvider._();

/// Streams the grouped agenda for the current day.

final class TodayAgendaProvider
    extends
        $FunctionalProvider<
          AsyncValue<TodayAgenda>,
          TodayAgenda,
          Stream<TodayAgenda>
        >
    with $FutureModifier<TodayAgenda>, $StreamProvider<TodayAgenda> {
  /// Streams the grouped agenda for the current day.
  TodayAgendaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayAgendaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayAgendaHash();

  @$internal
  @override
  $StreamProviderElement<TodayAgenda> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<TodayAgenda> create(Ref ref) {
    return todayAgenda(ref);
  }
}

String _$todayAgendaHash() => r'04338c08f5e6449f014e4f46413c3874131a873b';

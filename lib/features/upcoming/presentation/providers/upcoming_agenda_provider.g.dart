// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_agenda_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Streams the seven-day upcoming agenda (starting tomorrow).

@ProviderFor(upcomingAgenda)
final upcomingAgendaProvider = UpcomingAgendaProvider._();

/// Streams the seven-day upcoming agenda (starting tomorrow).

final class UpcomingAgendaProvider
    extends
        $FunctionalProvider<
          AsyncValue<UpcomingAgenda>,
          UpcomingAgenda,
          Stream<UpcomingAgenda>
        >
    with $FutureModifier<UpcomingAgenda>, $StreamProvider<UpcomingAgenda> {
  /// Streams the seven-day upcoming agenda (starting tomorrow).
  UpcomingAgendaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upcomingAgendaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upcomingAgendaHash();

  @$internal
  @override
  $StreamProviderElement<UpcomingAgenda> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UpcomingAgenda> create(Ref ref) {
    return upcomingAgenda(ref);
  }
}

String _$upcomingAgendaHash() => r'f279c2003ac314a55559c0487fe9c8169d87f783';

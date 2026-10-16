import 'dart:async';

/// Combines the latest values of two streams, emitting whenever either emits
/// after both have produced at least one value.
Stream<R> combineLatest2<A, B, R>(
  Stream<A> sourceA,
  Stream<B> sourceB,
  R Function(A a, B b) combine,
) {
  late final StreamController<R> controller;
  StreamSubscription<A>? subscriptionA;
  StreamSubscription<B>? subscriptionB;
  A? latestA;
  B? latestB;
  var hasA = false;
  var hasB = false;

  void emit() {
    if (hasA && hasB && !controller.isClosed) {
      controller.add(combine(latestA as A, latestB as B));
    }
  }

  controller = StreamController<R>(
    onListen: () {
      subscriptionA = sourceA.listen((value) {
        latestA = value;
        hasA = true;
        emit();
      }, onError: controller.addError);
      subscriptionB = sourceB.listen((value) {
        latestB = value;
        hasB = true;
        emit();
      }, onError: controller.addError);
    },
    onCancel: () async {
      await subscriptionA?.cancel();
      await subscriptionB?.cancel();
    },
  );
  return controller.stream;
}

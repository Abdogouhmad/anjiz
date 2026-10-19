import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/physics.dart';

import 'motion_tokens.dart';

/// Spring simulation helpers built from [AnjizMotion] tokens.
///
/// Springs must never fight the reduced-motion setting: whenever motion is
/// reduced, targets are jumped to instead of simulated, so no spring can
/// keep animating after the user or system asked for stillness.
abstract final class Springs {
  /// Creates a simulation moving [from] → [to] with [spring], swapping for the
  /// critically-damped [AnjizMotion.settled] spring when motion is reduced.
  static SpringSimulation simulation(
    SpringDescription spring,
    double from,
    double to,
  ) {
    final resolved = MotionTokens.reduced ? AnjizMotion.settled : spring;
    return SpringSimulation(resolved, from, to, 0);
  }

  /// Springs [controller] to [to] using [spring]; jumps instantly when motion
  /// is reduced. Returns a future that completes when the spring settles.
  ///
  /// Note: if the controller has no ticker attached or is muted/offstage, the
  /// returned future will complete only once the ticker ticks (or never if it
  /// never ticks) — the reduced-motion branch is the only guaranteed instant
  /// jump available from this helper.
  static Future<void> run(
    AnimationController controller,
    double to, {
    SpringDescription? spring,
  }) {
    if (MotionTokens.reduced) {
      controller.value = to;
      return Future<void>.value();
    }
    return controller.animateWith(
      simulation(spring ?? AnjizMotion.spatialStandard, controller.value, to),
    );
  }
}

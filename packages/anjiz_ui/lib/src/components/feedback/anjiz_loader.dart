import 'package:flutter/material.dart';

/// A centered activity indicator used while async state resolves.
class AnjizLoader extends StatelessWidget {
  /// Creates a loader.
  const AnjizLoader({this.label, super.key});

  /// Optional accessibility label.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        label: label,
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

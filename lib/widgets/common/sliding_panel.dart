import 'package:flutter/material.dart';

enum SlideDirection {
  left,
  right,
  top,
  bottom,
}

class SlidingPanel extends StatelessWidget {
  final Widget child;
  final SlideDirection direction;
  final ValueNotifier<bool> isVisible;

  const SlidingPanel({
    super.key,
    required this.child,
    required this.direction,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isVisible,
      builder: (_, value, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: direction == SlideDirection.left ? (value ? 0 : -200) : 0,
          right: direction == SlideDirection.right ? (value ? 0 : -200) : 0,
          top: direction == SlideDirection.top ? (value ? 0 : -200) : 0,
          bottom: direction == SlideDirection.bottom ? (value ? 0 : -200) : 0,
          child: child!,
        );
      },
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class Popover extends StatelessWidget {
  final Widget Function(VoidCallback open) target;
  final Widget Function(VoidCallback close) builder;

  const Popover({
    super.key,
    required this.target,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OverlayPortalController();
    final link = LayerLink();

    return CompositedTransformTarget(
      link: link,
      child: OverlayPortal(
        controller: controller,
        child: target(controller.toggle),
        overlayChildBuilder: (context) {
          return Stack(
            children: [
              ModalBarrier(
                onDismiss: () => controller.hide(),
              ),
              CompositedTransformFollower(
                link: link,
                targetAnchor: Alignment.topCenter,
                followerAnchor: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 200,
                  ),
                  child: builder(controller.hide),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

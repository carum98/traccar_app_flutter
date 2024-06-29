import 'package:flutter/material.dart';

import 'common/bottom_sheet.dart';
import 'common/sidebar.dart';
import 'common/sliding_panel.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget traccarMap;
  final Widget positions;
  final Widget player;
  final Widget tileProvider;
  final ValueNotifier<bool> hasData;

  const ResponsiveLayout({
    super.key,
    required this.traccarMap,
    required this.positions,
    required this.player,
    required this.tileProvider,
    required this.hasData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isLandscape = constraints.maxWidth > 600;

        if (isLandscape) {
          return _LandscapeLayout(this);
        } else {
          return _PortraitLayout(this);
        }
      },
    );
  }
}

class _LandscapeLayout extends StatelessWidget {
  final ResponsiveLayout layout;
  const _LandscapeLayout(this.layout);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        layout.traccarMap,
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: layout.tileProvider,
          ),
        ),
        SlidingPanel(
          direction: SlideDirection.bottom,
          isVisible: layout.hasData,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FittedBox(
                  child: layout.player,
                ),
              ),
            ),
          ),
        ),
        Sidebar(
          isVisible: layout.hasData,
          child: layout.positions,
        )
      ],
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  final ResponsiveLayout layout;
  const _PortraitLayout(this.layout);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        layout.traccarMap,
        ValueListenableBuilder(
          valueListenable: layout.hasData,
          builder: (_, value, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              right: 15,
              bottom: value ? 180 : 15,
              child: layout.tileProvider,
            );
          },
          child: layout.tileProvider,
        ),
        BottomSheetPermanent(
          isVisible: layout.hasData,
          children: [
            layout.player,
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: layout.positions,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

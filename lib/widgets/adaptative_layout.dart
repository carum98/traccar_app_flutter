import 'package:flutter/material.dart';

import 'bottom_sheet.dart';
import 'sidebar.dart';

class AddaptativeLayout extends StatelessWidget {
  final Widget traccarMap;
  final Widget positions;
  final Widget player;
  final Widget tileProvider;

  const AddaptativeLayout({
    super.key,
    required this.traccarMap,
    required this.positions,
    required this.player,
    required this.tileProvider,
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
  final AddaptativeLayout layout;
  const _LandscapeLayout(this.layout);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        layout.traccarMap,
        Positioned(
          right: 15,
          bottom: 15,
          child: layout.tileProvider,
        ),
        Align(
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
        Sidebar(
          child: layout.positions,
        )
      ],
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  final AddaptativeLayout layout;
  const _PortraitLayout(this.layout);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        layout.traccarMap,
        Positioned(
          right: 15,
          bottom: 180,
          child: layout.tileProvider,
        ),
        BottomSheetPermanent(
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

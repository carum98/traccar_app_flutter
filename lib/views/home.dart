import 'package:flutter/material.dart';
import 'package:traccar_app/state/map_state.dart';
import 'package:traccar_app/widgets/appbar_home.dart';
import 'package:traccar_app/widgets/bottom_sheet.dart';
import 'package:traccar_app/widgets/list_positions.dart';
import 'package:traccar_app/widgets/traccar_map.dart';
import 'package:traccar_app/widgets/position_player.dart';
import 'package:traccar_app/widgets/sidebar.dart';
import 'package:traccar_app/widgets/tile_provider_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarHome(),
      body: MapState(
        context: context,
        child: LayoutBuilder(
          builder: (_, constraints) {
            final isMobile = constraints.maxWidth < 600;

            const mobileLayout = [
              Positioned(
                right: 15,
                bottom: 180,
                child: TileProviderPicker(),
              ),
              BottomSheetPermanent(
                children: [
                  PositionPlayer(),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: ListPositions(),
                    ),
                  ),
                ],
              ),
            ];

            const deskLayout = [
              Positioned(
                right: 15,
                bottom: 15,
                child: TileProviderPicker(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: FittedBox(
                      child: PositionPlayer(),
                    ),
                  ),
                ),
              ),
              Sidebar(
                child: ListPositions(),
              )
            ];

            return Stack(
              children: [
                const TraccarMap(),
                ...isMobile ? mobileLayout : deskLayout,
              ],
            );
          },
        ),
      ),
    );
  }
}

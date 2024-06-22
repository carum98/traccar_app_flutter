import 'package:flutter/material.dart';
import 'package:traccar_app/core/map_state.dart';
import 'package:traccar_app/widgets/appbar_home.dart';
import 'package:traccar_app/widgets/bottom_sheet.dart';
import 'package:traccar_app/widgets/list_positions.dart';
import 'package:traccar_app/widgets/map.dart';
import 'package:traccar_app/widgets/position_player.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarHome(),
      body: MapState(
        context: context,
        child: const Stack(
          children: [
            TraccarMap(),
            BottomSheetPermanent(
              children: [
                PositionPlayer(),
                Expanded(child: ListPositions()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

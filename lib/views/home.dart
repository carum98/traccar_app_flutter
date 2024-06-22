import 'package:flutter/material.dart';
import 'package:traccar_app/core/map_state.dart';
import 'package:traccar_app/widgets/appbar_home.dart';
import 'package:traccar_app/widgets/bottom_sheet_scaffold.dart';
import 'package:traccar_app/widgets/map.dart';

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
          ],
        ),
      ),
      bottomSheet: const BottomSheetScaffold(
        child: Column(
          children: [
            Text('Bottom Sheet 2'),
          ],
        ),
      ),
    );
  }
}

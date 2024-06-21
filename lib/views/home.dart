import 'package:flutter/material.dart';
import 'package:traccar_app/core/map_state.dart';
import 'package:traccar_app/widgets/appbar_home.dart';
import 'package:traccar_app/widgets/map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    );
  }
}

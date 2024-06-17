import 'package:flutter/material.dart';
import 'package:traccar_app/widgets/map.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset('assets/logo.png'),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Traccar'),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
            onSelected: (String value) {
              if (value == 'logout') {
                // Logout
              }
            },
          ),
        ],
      ),
      body: const Stack(
        children: [
          TraccarMap(),
        ],
      ),
    );
  }
}

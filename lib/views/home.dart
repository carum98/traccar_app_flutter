import 'package:flutter/material.dart';
import 'package:traccar_app/core/dependency_inyection.dart';
import 'package:traccar_app/core/router_generator.dart';
import 'package:traccar_app/models/devices.dart';
import 'package:traccar_app/widgets/map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final devices = ValueNotifier<List<Devices>>([]);

  @override
  void dispose() {
    super.dispose();

    devices.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DI.of(context).apiService.getDevices().then((value) {
      devices.value = value;
    });

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
            onSelected: (String value) async {
              if (value == 'logout') {
                final value = await DI.of(context).authService.logout();

                if (value) {
                  await DI.of(context).syncStateStorage();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    LOGIN_VIEW,
                    (route) => false,
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          TraccarMap(
            markers: devices,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:traccar_app/core/dependency_inyection.dart';
import 'package:traccar_app/core/router_generator.dart';

class AppbarHome extends StatefulWidget implements PreferredSizeWidget {
  const AppbarHome({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<StatefulWidget> createState() => _AppbarHomeState();
}

class _AppbarHomeState extends State<AppbarHome> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          'assets/logo.png',
          color: Theme.of(context).textTheme.displayMedium?.color,
        ),
      ),
      title: const Text('Traccar'),
      actions: [
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'theme',
                child: Text('Switch theme'),
              ),
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

            if (value == 'theme') {
              final state = DI.of(context).state;

              state.setThemeMode(
                state.themeMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            }
          },
        ),
      ],
    );
  }
}

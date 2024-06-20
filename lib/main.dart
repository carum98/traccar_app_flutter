import 'package:flutter/material.dart';
import 'package:traccar_app/core/dependency_inyection.dart';
import 'package:traccar_app/core/theme.dart';

import 'core/router_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DI(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final state = DI.of(context).state;

    return ListenableBuilder(
      listenable: state,
      builder: (_, __) {
        return MaterialApp(
          title: 'Traccar',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: state.themeMode,
          onGenerateRoute: RouterGenerator.generate,
          navigatorKey: state.navigatorKey,
        );
      },
    );
  }
}

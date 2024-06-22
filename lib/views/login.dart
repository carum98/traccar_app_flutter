import 'package:flutter/material.dart';
import 'package:traccar_app/core/dependency_inyection.dart';
import 'package:traccar_app/core/router_generator.dart';
import 'package:traccar_app/views/server_register.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String email = '', password = '';

    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/logo_text.png',
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Email'),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  onChanged: (value) => email = value,
                ),
                const SizedBox(height: 20),
                const Text('Password'),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  onChanged: (value) => password = value,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final isAuth = await DI
                            .of(context)
                            .authService
                            .login(email, password);

                        if (isAuth) {
                          await DI.of(context).syncStateStorage();

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HOME_VIEW,
                            (route) => false,
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      openServerRegister(context);
                    },
                    child: const Text('Traccar Server'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

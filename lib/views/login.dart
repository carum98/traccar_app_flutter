import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
    );

    const labelStyle = TextStyle(
      fontSize: 18,
    );

    return Material(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/logo.png'),
                      const SizedBox(width: 10),
                      Image.asset('assets/logo_text.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Email', style: labelStyle),
                TextFormField(
                  decoration: inputDecoration.copyWith(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Password', style: labelStyle),
                TextFormField(
                  decoration: inputDecoration.copyWith(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Login
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
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

import 'package:flutter/material.dart';
import 'package:traccar_app/core/storage.dart';

Future<void> openServerRegister(BuildContext context) async {
  final isLargeScreen = MediaQuery.of(context).size.width > 600;

  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: SizedBox(
        width: isLargeScreen ? MediaQuery.of(context).size.width / 2 : null,
        child: const ServerRegisterView(),
      ),
    ),
  );
}

class ServerRegisterView extends StatefulWidget {
  const ServerRegisterView({super.key});

  @override
  State<ServerRegisterView> createState() => _ServerRegisterViewState();
}

class _ServerRegisterViewState extends State<ServerRegisterView> {
  final storage = Storage();
  final _serverUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    storage.read(StorageKey.serverUrl).then((value) {
      if (value != null) {
        _serverUrlController.text = value;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _serverUrlController.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      storage.write(
        key: StorageKey.serverUrl,
        value: _serverUrlController.text,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autofocus: true,
              controller: _serverUrlController,
              decoration: const InputDecoration(
                hintText: 'Server API URL',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _register,
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

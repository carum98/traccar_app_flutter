import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum StorageKey {
  serverUrl,
  cookies,
}

class Storage {
  final storage = const FlutterSecureStorage();

  static final Storage _singleton = Storage._internal();
  Storage._internal();
  factory Storage() => _singleton;

  Future<String?> read(StorageKey key) async {
    return await storage.read(key: key.toString());
  }

  Future<void> write({required StorageKey key, required String value}) async {
    await storage.write(key: key.toString(), value: value);
  }

  Future<void> delete(StorageKey key) async {
    await storage.delete(key: key.toString());
  }

  Future<bool> contains(StorageKey key) async {
    return await storage.containsKey(key: key.toString());
  }
}

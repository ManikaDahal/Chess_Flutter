import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveUser(String uid) async {
    await _storage.write(key: 'uid', value: uid);
  }

  Future<String?> getUser() async {
    return await _storage.read(key: 'uid');
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}

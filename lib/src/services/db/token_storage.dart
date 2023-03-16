import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Token Storage
class TokenStorage {
  final _storage = const FlutterSecureStorage();

  /// Clear Token
  void clearToken() async {
    await _storage.delete(key: "token");
  }

  /// Get Token
  Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  /// Set Token
  Future<void> setToken(String token) async {
    await _storage.write(key: "token", value: token);
  }
}

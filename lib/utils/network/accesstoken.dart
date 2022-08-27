import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class AccessToken {
  static getToken() async {
    String? token = await storage.read(key: 'token');
    return 'Bearer $token';
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage storeTokenValue = const FlutterSecureStorage();

Future storeToken(String key, String token) async {
  await storeTokenValue.write(key: key, value: token);
}

Future getToken(String key) async {
  return await storeTokenValue.read(key: key) ?? '';
}

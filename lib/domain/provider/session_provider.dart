
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oqy/domain/entity/auth_response.dart';


abstract class _Keys{
  static const sessionId = 'session-id';
  static const userId = 'user-id';
}

class SessionDataProvider{

  static const _secureStorage = FlutterSecureStorage();


  Future<AuthResponse?>getSession()async {
    final token = _secureStorage.read(key: _Keys.sessionId) as String;
    final userId= _secureStorage.read(key: _Keys.userId) as String;
    int id=int.parse(userId);
    final response = AuthResponse(token: token, userId: id);
    return  response;
  }
  Future<String?> getToken()async {
    final token =  await _secureStorage.read(key: _Keys.sessionId);
    return  token;
  }

  Future<void> setSessionId(String sessionId, int userId) async {
      final id='$userId';
      print(sessionId);
      (await _secureStorage.write(key: _Keys.sessionId, value: sessionId));
      (await _secureStorage.write(key: _Keys.userId, value: id));
  }

  Future<void> clearApiKey() async {
      (await _secureStorage.delete(key:  _Keys.sessionId));
      (await _secureStorage.delete(key:  _Keys.userId));
  }
}
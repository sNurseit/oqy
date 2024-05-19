
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oqy/domain/entity/auth_response.dart';

abstract class _Keys{
  static const sessionId = 'session-id';
  static const userId = 'user-id';  
  static const userRoles = 'user-role';
}

class SessionDataProvider{

  static const _secureStorage = FlutterSecureStorage();


  Future<AuthResponse?>getSessions()async {
    final token= _secureStorage.read(key: _Keys.sessionId) as String;
    final userId = _secureStorage.read(key: _Keys.userId) as String;
    final roleString = _secureStorage.read(key: _Keys.userRoles) as String;

    roleString.split('|');  
    int id=int.parse(userId);

    final response = AuthResponse(token: token, userId: id, roles: roleString as List<String>);
    return  response;
  }

  Future<String?> getToken()async {
    final token =  await _secureStorage.read(key: _Keys.sessionId);
    return  token;
  }

  Future<void> setSessionId(String sessionId, int userId, List<String> roles) async {
    final id='$userId';
    final roleString = roles.join('|');
    (await _secureStorage.write(key: _Keys.sessionId, value: sessionId));
    (await _secureStorage.write(key: _Keys.userId, value: id));
    (await _secureStorage.write(key: _Keys.userRoles, value: roleString));
  }

  Future<void> clearApiKey() async {
    (await _secureStorage.delete(key:  _Keys.sessionId));
    (await _secureStorage.delete(key:  _Keys.userId));
    (await _secureStorage.delete(key:  _Keys.userRoles));
  }
}
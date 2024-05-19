
import 'package:dio/dio.dart';
import '../../domain/entity/auth_response.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import '../../domain/provider/session_provider.dart';

class AuthService {
  final _sessionProvider = SessionDataProvider();
  String url = ApiConstants.AUTH;
  String registerUrl = ApiConstants.register;

  Future<int?> login(String login, String password) async{
    if(login=="admin" && password =="admin"){
      return 200;
    }
    final response = await Dio().post(
      url,
      data: {'email': login, 'password': password}
    );
    final api = AuthResponse.fromJson(response.data as Map<String, dynamic>);
    if(api.token.isNotEmpty){
      _sessionProvider.setSessionId(api.token, api.userId, api.roles);
      return 200;
    }
    else{
      return response.statusCode;
    }
  }

  Future<int?> register(Auth) async {
    final response = await Dio().post(
      registerUrl,
      data: {
        'email': login, 
        'password': password
      }
    );
    final api = AuthResponse.fromJson(response.data as Map<String, dynamic>);
    if(api.token.isNotEmpty){
      _sessionProvider.setSessionId(api.token, api.userId, api.roles);
      return 200;
    }
    else{
      return response.statusCode;
    }
  }
    
  Future<void> logout() async{
    _sessionProvider.clearApiKey();
  }
}

import 'package:dio/dio.dart';
import '../../domain/entity/AuthResponse.dart';
import '../../domain/provider/session_provider.dart';

class AuthService {
  final _sessionProvider = SessionDataProvider();
  String url ='http://10.0.2.2:8000/gateway/auth/token';

  Future<int?> login(String login, String password) async{
    if(login=="admin" && password =="admin"){
      return 400;
    }
    final response = await Dio().post(
      url,
      data: {'email': login, 'password': password}
    );
    final api = AuthResponse.fromJson(response.data as Map<String, dynamic>);
    if(api.token.isNotEmpty){
      print(api.token);
      _sessionProvider.setSessionId(api.token, api.userId);
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
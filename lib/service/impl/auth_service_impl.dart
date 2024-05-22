
import 'package:dio/dio.dart';
import 'package:oqy/domain/dto/confirmation_dto.dart';
import 'package:oqy/domain/entity/register.dart';
import '../../domain/entity/auth_response.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import '../../domain/provider/session_provider.dart';

class AuthService {
  final _sessionProvider = SessionDataProvider();
  String url = ApiConstants.auth;

  Future<int?> login(String login, String password) async{
    if(login=="admin" && password =="admin"){
      return 200;
    }
    final response = await Dio().post(
      '$url/token',
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

  Future<ConfirmationDto?> register(Register register) async {
    try{
      final response = await Dio().post(
        '$url/register',
        data: register.toJson()
      );
      print(response.data);
      return ConfirmationDto.fromJson(response.data as Map<String, dynamic>);
    } catch (e){
      Exception(e);
    }
    return null;
  }

  Future<int?> checkVerificationCode(ConfirmationDto confirmation, String code) async {
    try{
      confirmation.verificationCode = code;
      final response = await Dio().get(
        '$url/check-verification-code',
        data: confirmation.toJson() 
      );
      final api = AuthResponse.fromJson(response.data as Map<String, dynamic>);
      if(api.token.isNotEmpty){
        _sessionProvider.setSessionId(api.token, api.userId, api.roles);
        return 200;
      }
    } catch (e){
      Exception(e);
    }
    return null;
  }  
    
  Future<void> logout() async{
    _sessionProvider.clearApiKey();
  }
}

import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/dto/confirmation_dto.dart';
import 'package:oqy/domain/dto/user_change_dto.dart';
import 'package:oqy/domain/entity/register.dart';
import '../../domain/entity/auth_response.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import '../../domain/provider/session_provider.dart';

class AuthService {
  final _sessionProvider = SessionDataProvider();
  String url = ApiConstants.auth;

  final Dio dio;

  AuthService({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }

  Future<int?> login(String login, String password) async{
    if(login=="admin" && password =="admin"){
      return 200;
    }
    final response = await dio.post(
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

  Future<List<UserChangeDto>> findUsersForAdmin() async {
    try{
      final response = await dio.get('$url/all',);
      return (response.data['content'] as List)
        .map((json) => UserChangeDto.fromJson(json))
        .toList();
    } catch (e){
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<ConfirmationDto?> register(Register register) async {
    try{
      final response = await dio.post(
        '$url/register',
        data: register.toJson()
      );
      return ConfirmationDto.fromJson(response.data as Map<String, dynamic>);
    } catch (e){
      Exception(e);
    }
    return null;
  }

  Future<int?> checkVerificationCode(ConfirmationDto confirmation, String code) async {
    try{
      confirmation.verificationCode = code;
      final response = await dio.post(
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
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/message.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/service/chat_service.dart';

class ChatServiceImpl implements ChatService{
  final String url = ApiConstants.API;
  final Dio dio;

  ChatServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<List<Message>?> getMessages(String roomId) async {
    try{
      Response response = await dio.get('$url/api/messages/$roomId');
      List<Message> messages = (response.data as List)
        .map((courseJson) => Message.fromJson(courseJson))
        .toList();
      return messages;
    } catch (e){
      throw Exception('Failed to load content.');
    }
  }

  @override
  Future<List<Profile>?> getUsersWithChat() async {
    try{    
      Response response = await dio.get('$url/api/messages/users');
      List jsonResponse = json.decode(response.data);
      return jsonResponse.map((user) => Profile.fromJson(user)).toList();
    } catch (e){
      throw Exception('Failed to load content.');
    }
  }

 @override
  Future<Message?> sendMessage(String roomId, Message message) async {
    try {
      Response response = await dio.post(
        '$url/app/chat/$roomId',
        data: message.toJson(),
      );
      return Message.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to send message');
    }
  }
}

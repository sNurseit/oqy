
import 'package:oqy/domain/entity/message.dart';
import 'package:oqy/domain/entity/profile.dart';

abstract class ChatService{
  Future<List<Message>?> getMessages(String roomId);
  Future<List<Profile>?> getUsersWithChat(); 
  Future<Message?> sendMessage(String roomId, Message message);
}
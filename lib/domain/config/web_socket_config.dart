import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/entity/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketConfig {
  final String url = ApiConstants.API;
  WebSocketChannel? _channel;

  void connect(String roomId) {
    _channel = WebSocketChannel.connect(Uri.parse('$url/chat-socket'));
  }

  Stream get stream => _channel!.stream.map((message) => Message.fromJson(json.decode(message)));

  void sendMessage(Message message) {
    _channel!.sink.add(json.encode(message.toJson()));
  }

  void disconnect() {
    _channel!.sink.close();
  }
}

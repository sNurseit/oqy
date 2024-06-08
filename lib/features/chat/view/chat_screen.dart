
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/config/web_socket_config.dart';
import 'package:oqy/domain/entity/message.dart';
import 'package:oqy/domain/entity/profile.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final Profile profile;


  const ChatScreen({super.key, 
    required this.profile,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final WebSocketConfig webSocketConfig = WebSocketConfig();
  late Future<List<Message>> _futureMessages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_futureMessages = widget.chatService.getMessages(widget.roomId)!;
   // webSocketConfig.connect(widget.roomId);
  }

  @override
  void dispose() {
    webSocketConfig.disconnect();
    super.dispose();
  }
/*
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = Message(
        id: '',
        roomId: widget.roomId,
        message: _controller.text,
        sender: 'me',
        timestamp: DateTime.now(),
      );
      widget.webSocketConfig.sendMessage(message);
      _controller.clear();
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      //  title: Text('Chat Room ${widget.roomId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Message>>(
              future: _futureMessages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final messages = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        title: Text(message.message??''),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed:(){} //_sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

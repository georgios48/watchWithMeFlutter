import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:watch_with_me/models/message_model.dart';
import 'package:watch_with_me/models/room_model.dart';
import 'package:watch_with_me/sharedPreferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.room,
  }) : super(key: key);
  final RoomModelResponse room;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  late WebSocketChannel _channel;

  final ScrollController _scrollController = ScrollController();

  final _preferencesService = WatchSharedPreferences();

  @override
  void initState() {
    super.initState();
    _initWebSocket();
  }

  void _initWebSocket() async {
    final userData = await _preferencesService.getPreferences();
    _channel = IOWebSocketChannel.connect(Uri.parse(
            // TODO: To be changed to 'wss', when HTTPS is supported in Django
            'ws://192.168.0.44:8000/ws/chat_app/${widget.room.uniqueID}/'),
        headers: {'Authorization': 'Token ${userData.token}'});
    _channel.stream.listen((message) {
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void _sendMessage(String message) async {
    final userData = await _preferencesService.getPreferences();
    if (message.isNotEmpty) {
      MessageRequest messageRequest = MessageRequest(
          message: _controller.text,
          username: userData.username,
          roomID: widget.room.uniqueID);

      _channel.sink.add(jsonEncode(messageRequest.toJson()));
    }
    // clear textfield
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListView(children: [
                  Text(_messages[index]), //TODO: add scroll to bottom
                ]);
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.amber),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _handleSubmitted(_controller.text);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String message) {
    _sendMessage(message);
  }
}

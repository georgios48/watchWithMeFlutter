import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:watch_with_me/models/message_model.dart';
import 'package:watch_with_me/models/room_model.dart';
import 'package:watch_with_me/servicesAPI/weboscket_service.dart';
import 'package:watch_with_me/sharedPreferences/shared_preferences.dart';
import 'package:watch_with_me/utils/awesome_snackbar.dart';
import 'package:watch_with_me/utils/constants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatExpandedPage extends StatefulWidget {
  const ChatExpandedPage({
    Key? key,
    required this.room,
    required this.deviceWidth,
    required this.deviceHeight,
  }) : super(key: key);

  final RoomModelResponse room;
  final double deviceWidth;
  final double deviceHeight;

  @override
  State<ChatExpandedPage> createState() => _ChatExpandedPageState();
}

class _ChatExpandedPageState extends State<ChatExpandedPage> {
  final TextEditingController _textFieldController = TextEditingController();

  final List<MessageResponse> _messages = [];
  late WebSocketChannel _channel;

  bool isChatButtonActive = false;
  final ScrollController _scrollController = ScrollController();
  bool isUser = false;

  final _preferencesService = WatchSharedPreferences();
  late String _currentUserUsername;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // get all previous messages for the room
    _fetchPreviousMessages();

    // init user preferences
    _initSharedPreferences();

    // init WebSocket
    _initWebSocket();

    // init the scroll controlled
    _scrollController.addListener(_scrollListener);
    _scrollToBottom();

    // init textField listened in order to make button unavailable
    _textFieldController.addListener(() {
      bool isChatButtonActive = _textFieldController.text.isNotEmpty;

      setState(() {
        this.isChatButtonActive = isChatButtonActive;
      });
    });
  }

  void _initSharedPreferences() async {
    // init user shared preferences
    final preferences = await _preferencesService.getPreferences();
    _currentUserUsername = preferences.username;
  }

  void _scrollListener() {
    // Checks if it needs to be scrolled or will get OOR
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {}
  }

  void _scrollToBottom() {
    // TODO: does not work as expceted, sometimes it is not all the way scrolled.
    // Scrolls to bottom if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _initWebSocket() async {
    // init WebSocket

    final userData = await _preferencesService.getPreferences();

    _channel = IOWebSocketChannel.connect(Uri.parse(
            // TODO: To be changed to 'wss', when HTTPS is supported in Django
            'ws://192.168.0.44:8000/ws/chat_app/${widget.room.uniqueID}/'),
        headers: {'Authorization': 'Token ${userData.token}'});
    _channel.stream.listen((message) {
      setState(() {
        final decodedMessage = jsonDecode(message);
        _messages.add(MessageResponse.fromJson(decodedMessage));
      });
    });
  }

  void _sendMessage(String message) async {
    // Sends message to the WebSocket
    final userData = await _preferencesService.getPreferences();
    if (message.isNotEmpty) {
      MessageRequest messageRequest = MessageRequest(
          message: _textFieldController.text,
          username: userData.username,
          roomID: widget.room.uniqueID);

      _channel.sink.add(jsonEncode(messageRequest.toJson()));
    }
    // clear textfield
    _textFieldController.clear();
    _scrollToBottom();
  }

  void _fetchPreviousMessages() async {
    // get all previous messages for the room

    final websocketService = WebSocketService();

    try {
      await websocketService
          .fetchPreviousMessage(widget.room.uniqueID)
          .then((messages) {
        if (messages.isEmpty) {
          setState(() {
            _isLoading = false;
          }); //hid
        } else {
          for (var i = 0; i < messages.length; i++) {
            _messages.add(messages[i]);
            setState(() {
              _isLoading = false;
            }); //hide loader
          }
        }

        _scrollToBottom();
      });
    } on Exception catch (e) {
      SnackBar snackBar = CustomSnackbar().displaySnacbar(0, e.toString());

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    // dispose scrollController
    _scrollController.dispose();

    // dispose WebSocket (closes)
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if the request is still fetching messages, show progress indicator
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: whitePrimary,
        body: Center(
            child: CircularProgressIndicator(
                color: bluePrimary, backgroundColor: whitePrimary)),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            'Chat',
            style: TextStyle(
                fontFamily: 'Chalet',
                fontWeight: FontWeight.w300,
                fontSize: widget.deviceWidth * 0.06),
          ),
        ),
        backgroundColor: whitePrimary,
        body: Hero(
          tag: 'chatWindow',
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final message = _messages[index];
                      final isCurrentUser =
                          message.username == _currentUserUsername;
                      return ListTile(title: _chatRow(isCurrentUser, message));
                    }),
              ),
              const Divider(height: 1.0),
              _buildTextComposer(),
              SizedBox(
                height: widget.deviceHeight * 0.02,
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _buildTextComposer() {
    return SizedBox(
      width: widget.deviceWidth,
      child: TextField(
        autofocus: true,
        controller: _textFieldController,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: true,
          fillColor: whitePrimary,
          suffixIcon: IconButton(
            icon: Icon(Icons.send_rounded,
                color: isChatButtonActive ? orangePrimary : Colors.grey[400]),
            onPressed: isChatButtonActive
                ? () {
                    _sendMessage(_textFieldController.text);
                  }
                : null,
          ),
          hintStyle: TextStyle(fontSize: widget.deviceWidth * 0.03),
          hintText: 'Write a message...',
        ),
      ),
    );
  }

  Widget _chatRow(bool isCurrentUser, MessageResponse message) {
    // Positions the message depending on if the current user sent it or not
    if (isCurrentUser) {
      return Wrap(
        alignment: WrapAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                message.username,
                style: const TextStyle(color: orangePrimary),
                overflow: TextOverflow.visible,
              ),
            ],
          ),
          Text(
            message.message,
            overflow: TextOverflow.visible,
          )
        ],
      );
    } else {
      return SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  message.username,
                  style: const TextStyle(color: orangePrimary),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
            Text(
              message.message,
              overflow: TextOverflow.visible,
            )
          ],
        ),
      );
    }
  }
}

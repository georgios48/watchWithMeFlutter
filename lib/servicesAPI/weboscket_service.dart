import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:watch_with_me/models/message_model.dart';
import 'package:watch_with_me/servicesAPI/routes.dart';
import 'package:watch_with_me/sharedPreferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WebSocketService {
  final _preferencesService = WatchSharedPreferences();
  final _routes = WebSocketRoutes();
  Future<List<MessageResponse>> fetchPreviousMessage(String roomID) async {
    final userData = await _preferencesService.getPreferences();

    try {
      final response = await http.get(
          Uri.parse("${_routes.getPreviousMessagesURL}?room_id=$roomID"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token ${userData.token}'
          });

      switch (response.statusCode) {
        case 200:
          Iterable json = jsonDecode(response.body);
          return json
              .map((message) => MessageResponse.fromJson(message))
              .toList();
        case 404:
        case 500:
          final data = jsonDecode(response.body);
          throw Exception(data['Error']);
        default:
          throw Exception(response.reasonPhrase);
      }
    } on SocketException {
      throw Exception("No internet connection");
    } on TimeoutException catch (e) {
      throw Exception("Connection timeout: ${e.message} ");
    } on Exception {
      rethrow;
    }
  }
}

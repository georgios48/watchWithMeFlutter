import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch_with_me/models/room_model.dart';
import 'package:watch_with_me/servicesAPI/routes.dart';
import 'package:watch_with_me/sharedPreferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RoomService {
  RoomRoutes roomRoutes = RoomRoutes();

  final _preferencesService = WatchSharedPreferences();

  Future<List> createRoom(RoomModelRequest postBody) async {
    if (postBody.roomPassword!.trim().isEmpty) {
      postBody.roomPassword = null;
    }

    if (postBody.roomName!.trim().isEmpty) {
      postBody.roomName = null;
    }

    try {
      final userData = await _preferencesService.getPreferences();

      final response = await http.post(Uri.parse(roomRoutes.roomsURL),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token ${userData.token}'
          },
          body: jsonEncode(postBody.toJson()));

      switch (response.statusCode) {
        case 201:
          final data = jsonDecode(response.body);
          return [response.statusCode, data["Success"]];

        case 400:
        case 404:
          final data = jsonDecode(response.body);
          return [response.statusCode, data["Error"]];

        case 500:
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

  Future<List<RoomModelResponse>> getUserRooms() async {
    try {
      final userData = await _preferencesService.getPreferences();

      final response =
          await http.get(Uri.parse(roomRoutes.extendedRoomsURL), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ${userData.token}'
      });

      switch (response.statusCode) {
        case 200:
          Iterable json = jsonDecode(response.body);
          return json.map((room) => RoomModelResponse.fromJson(room)).toList();

        case 400:
        case 404:
        case 500:
        case 406:
          throw Exception(response.body);
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

// entry port for data, used to manage states. Creates shared state.
// the ref is more like a context for the Riverpod. Returns a func (can be a simple value or widget instead)
// kinda like dependency injection
final roomProvider = Provider<RoomService>((ref) => RoomService());

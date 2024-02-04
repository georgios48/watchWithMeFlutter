import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:watch_with_me/models/user_model.dart';
import 'package:watch_with_me/servicesAPI/routes.dart';
import 'package:watch_with_me/sharedPreferences/shared_preferences.dart';

class UserService {
  UserRoutes userRoutes = UserRoutes();
  final _preferencesService = WatchSharedPreferences();

  Future<List> registerUser(RegisterUserRequest postBody) async {
    try {
      final response = await http.post(
          Uri.parse(userRoutes.userRegistrationURL),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(postBody.toJson()));

      switch (response.statusCode) {
        case 201:
          final data = jsonDecode(response.body);

          return [response.statusCode, data["Success"]];

        case 400:
          final data = jsonDecode(response.body);

          return [response.statusCode, data["Error"]];

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

  Future<List> loginUser(LoginUserRequest postBody) async {
    try {
      final response = await http.post(Uri.parse(userRoutes.userLoginURL),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(postBody.toJson()));

      switch (response.statusCode) {
        case 202: // created
          final data = jsonDecode(response.body);

          await _preferencesService.removeAllPreferences();
          await _preferencesService.savePreferences(
              data["username"], data["token"]);
          return [response.statusCode, ""];

        case 400: // password does not match
          final data = jsonDecode(response.body);
          return [response.statusCode, data["Error"]];

        case 403: // user email not activated
          final data = jsonDecode(response.body);
          return [response.statusCode, data["Error"]];

        case 404: // user does not exist
          final data = jsonDecode(response.body);
          return [response.statusCode, data["Error"]];

        case 431: // max auth created
          final data = jsonDecode(response.body);
          return [response.statusCode, data["Error"]];

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

  Future<List> getUserActivationStatus(String username) async {
    final parseURL = "${userRoutes.userRegistrationURL}?username=$username";
    bool status = false;
    while (!status) {
      try {
        final response = await http.get(Uri.parse(parseURL),
            headers: {'Content-Type': 'application/json; charset=UTF-8'});

        switch (response.statusCode) {
          case 200:
            status = jsonDecode(response.body)["is_active"];

            if (status) {
              return [response.statusCode, status];
            }

          case 404:
            String message = jsonDecode(response.body)["Error"];
            return [
              response.statusCode,
              "$message Please contact the support in order to solve this issue."
            ];

          default:
            throw Exception(response.reasonPhrase);
        }
      } on SocketException {
        throw Exception("No internet connection");
      } on TimeoutException catch (e) {
        throw Exception("Connection timeout: ${e.message} ");
      }

      await Future.delayed(const Duration(seconds: 2));
    }
    throw Exception("Unexpected error occured");
  }
}

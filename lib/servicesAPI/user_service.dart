import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:watch_with_me/models/user_model.dart';
import 'package:watch_with_me/servicesAPI/routes.dart';
import 'package:watch_with_me/utils/awesome_snackbar.dart';

class UserService {
  UserRoutes userRoutes = UserRoutes();

  CustomSnackbar customSnackbar = CustomSnackbar();

  Future<List> registerUser(RegisterUserRequest postBody) async {
    try {
      final response = await http.post(
          Uri.parse(userRoutes.userRegistrationURL),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(postBody.toJson()));

      switch (response.statusCode) {
        case 201:
          final data = jsonDecode(response.body);

          // return customSnackbar.displaySnacbar(
          //     response.statusCode, data["Success"]);
          return [response.statusCode, data["Success"]];

        case 400:
          final data = jsonDecode(response.body);
          // return customSnackbar.displaySnacbar(
          //     response.statusCode, data["Error"]);

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
}

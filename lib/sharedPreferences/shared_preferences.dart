import 'package:shared_preferences/shared_preferences.dart';

class WatchSharedPreferences {
  Future savePreferences(String username, String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString("username", username);
    await preferences.setString("token", token);
  }

  Future<List> getPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final username = preferences.getString("username");
    final token = preferences.getString("token");

    return [username, token];
  }

  // TODO: add delete sessions for logging out
}

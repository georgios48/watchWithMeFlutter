import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_with_me/sharedPreferences/preferences_model.dart';

class WatchSharedPreferences {
  Future savePreferences(String username, String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString("username", username);
    await preferences.setString(username, token);
  }

  Future<Preferences> getPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final username = preferences.getString("username");
    final token = preferences.getString(username!);

    return Preferences(username: username, token: token!);
  }

  Future removeAllPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.clear();
  }
}

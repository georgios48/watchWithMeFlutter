import 'package:flutter/material.dart';
import 'package:watch_with_me/components/rounded_button.dart';
import 'package:watch_with_me/sharedPreferences/shared_preferences.dart';
import 'package:watch_with_me/utils/awesome_snackbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _preferencesService = WatchSharedPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Row(
          children: [
            RoundedButton(
                text: "text",
                press: () {
                  _preferencesService.getPreferences().then((value) {
                    SnackBar snackBar =
                        CustomSnackbar().displaySnacbar(200, value[1]);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  });
                })
          ],
        )));
  }
}

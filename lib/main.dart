import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch_with_me/pages/main_page.dart';
import 'package:watch_with_me/pages/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home:
                // TODO: change to SplashScreen()
                // TODO: fix auto login when valid session
                // TODO: fix app launch icon
                SplashScreen()));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch_with_me/pages/main_page.dart';
import 'package:watch_with_me/pages/splash_screen.dart';
import 'package:watch_with_me/pages/test_page.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: MainPage()));
  }
}

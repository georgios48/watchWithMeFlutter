import 'package:flutter/material.dart';
import 'package:watch_with_me/pages/landing_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
        child: MaterialApp(
            debugShowCheckedModeBanner: false, home: LandingScreen()));
  }
}

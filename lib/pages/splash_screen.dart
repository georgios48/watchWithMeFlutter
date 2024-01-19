import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_with_me/pages/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  // on init of the screen
  @override
  void initState() {
    super.initState();
    // Removes top and bottom bar on init
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // how long the screen is visible
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LandingScreen()));
    });
  }

  // on disposal of the screen
  @override
  void dispose() {
    // enables the top and bottom bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color:  Color(0xFFDF862D)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset("assets/watchWithMeLogo.png"),
        ]
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_with_me/pages/landing_screen.dart';
import 'package:watch_with_me/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // on init of the screen
  @override
  void initState() {
    super.initState();
    // Removes top and bottom bar on init
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // how long the screen is visible
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LandingScreen()));
    });
  }

  // on disposal of the screen
  @override
  void dispose() {
    // enables the top and bottom bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // UI screen size
    final size = MediaQuery.of(context).size;
    double deviceWidth = size.width;

    return Scaffold(
      backgroundColor: orangePrimary,
      body: SizedBox(
        width: deviceWidth,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/watchWithMeLogo.png"),
        ]),
      ),
    );
  }
}

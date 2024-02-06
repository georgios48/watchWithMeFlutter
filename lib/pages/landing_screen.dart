import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_with_me/components/rounded_button.dart';
import 'package:watch_with_me/pages/user/login_page.dart';
import 'package:watch_with_me/pages/user/register_screen.dart';
import 'package:watch_with_me/utils/constants.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    // UI screen size
    Size size = MediaQuery.of(context).size;

    double deviceWidth = size.width;
    double deviceHeight = size.height;

    return Scaffold(
      backgroundColor: orangePrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 72),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Unlimited \nStreaming",
                    style: TextStyle(
                        fontFamily: 'Chalet',
                        fontSize: deviceWidth * 0.10,
                        height: deviceHeight * 0.001),
                  ),

                  SizedBox(height: deviceHeight * 0.12),

                  Text("Watch",
                      style: TextStyle(
                          fontFamily: 'Chalet',
                          fontSize: deviceWidth * 0.15,
                          color: whitePrimary,
                          fontWeight: FontWeight.w100,
                          height: deviceHeight * 0.001)),
                  Text("With",
                      style: TextStyle(
                          fontFamily: 'Chalet',
                          fontSize: deviceWidth * 0.15,
                          color: bluePrimary,
                          fontWeight: FontWeight.w100,
                          height: deviceHeight * 0.001)),
                  Text("Me",
                      style: TextStyle(
                          fontFamily: 'Chalet',
                          fontSize: deviceWidth * 0.15,
                          color: whitePrimary,
                          fontWeight: FontWeight.w100,
                          height: deviceHeight * 0.001)),

                  SizedBox(height: deviceHeight * 0.20),

                  // button
                  RoundedButton(
                      text: "Get Started",
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }));
                      }),

                  SizedBox(height: deviceHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have an account?',
                          style: TextStyle(color: whitePrimary)),
                      TextButton(
                          onPressed: () {
                            // take you to register page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: const Text(
                            'Sign Up!',
                            style: TextStyle(
                                color: whitePrimary,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

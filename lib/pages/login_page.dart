import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watch_with_me/components/rounded_button.dart';
import 'package:watch_with_me/pages/register_screen.dart';
import 'package:watch_with_me/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextFields controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // UI screen size
    Size size = MediaQuery.of(context).size;

    double deviceWidth = size.width;
    double deviceHeight = size.height;

    return Scaffold(
      backgroundColor: bluePrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 72),
            color: bluePrimary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Chalet',
                      fontSize: deviceWidth * 0.12,
                      fontWeight: FontWeight.w100,
                      color: orangePrimary,
                      height: deviceHeight * 0.001),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: whitePrimary)),
                    TextButton(
                        onPressed: () {
                          // take you to login page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen()));
                        },
                        child: const Text('Sign Up!',
                            style: TextStyle(
                                color: whitePrimary,
                                fontWeight: FontWeight.bold)))
                  ],
                ),

                SizedBox(height: deviceHeight * 0.07),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your username",
                    style: TextStyle(
                        fontSize: deviceWidth * 0.04,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: whitePrimary),
                  ),
                ),

                SizedBox(height: deviceHeight * 0.008),

                // username textField
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: whitePrimary,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                        hintText: 'Enter your username',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 174, 173, 173))),
                  ),
                ),

                SizedBox(height: deviceHeight * 0.008),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your password",
                    style: TextStyle(
                        fontSize: deviceWidth * 0.04,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: whitePrimary),
                  ),
                ),

                SizedBox(height: deviceHeight * 0.008),

                // password textField
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: whitePrimary,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                        hintText: 'Enter your password',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 174, 173, 173))),
                  ),
                ),

                SizedBox(height: deviceHeight * 0.10),

                RoundedButton(
                    text: "Sign Up", color: orangePrimary, press: () {}),

                // OR
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: const Divider(
                          height: 36,
                        )),
                  ),
                  const Text("Or",
                      style: TextStyle(
                          color: Color(0xFFA1A0A0), fontFamily: 'Chalet')),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: const Divider(
                          height: 36,
                        )),
                  ),
                ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextButton.icon(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(orangePrimary)),
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Facebook",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                    SizedBox(width: deviceWidth * 0.01),
                    Expanded(
                      flex: 5,
                      child: TextButton.icon(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(orangePrimary)),
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Google",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

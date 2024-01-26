import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watch_with_me/components/rounded_button.dart';
import 'package:watch_with_me/models/user_model.dart';
import 'package:watch_with_me/pages/login_page.dart';
import 'package:watch_with_me/pages/verifying_account_screen.dart';
import 'package:watch_with_me/servicesAPI/user_service.dart';
import 'package:watch_with_me/utils/awesome_snackbar.dart';
import 'package:watch_with_me/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // TextFields controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    // user service

    // UI screen size
    Size size = MediaQuery.of(context).size;

    double deviceWidth = size.width;
    double deviceHeight = size.height;

    return Scaffold(
      backgroundColor: bluePrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
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
                    const Text('Already have an account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: whitePrimary)),
                    TextButton(
                        onPressed: () {
                          // take you to login page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text('Sign In!',
                            style: TextStyle(
                                color: whitePrimary,
                                fontWeight: FontWeight.bold)))
                  ],
                ),

                SizedBox(height: deviceHeight * 0.03),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your e-mail",
                    style: TextStyle(
                        fontSize: deviceWidth * 0.04,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: whitePrimary),
                  ),
                ),

                SizedBox(height: deviceHeight * 0.008),

                // email textField
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        errorText: "Required field",
                        filled: true,
                        fillColor: whitePrimary,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                        hintText: 'Enter your e-mail',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 174, 173, 173))),
                  ),
                ),

                SizedBox(height: deviceHeight * 0.008),

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

                // email textField
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          errorText: "Required field",
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
                        errorText: "Required field",
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

                SizedBox(height: deviceHeight * 0.008),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm your password",
                    style: TextStyle(
                        fontSize: deviceWidth * 0.04,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: whitePrimary),
                  ),
                ),

                SizedBox(height: deviceHeight * 0.008),

                // confirm password textField
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    obscureText: true,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                        errorText: "Required field",
                        filled: true,
                        fillColor: whitePrimary,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                        hintText: 'Confirm your password',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 174, 173, 173))),
                  ),
                ),

                SizedBox(height: deviceHeight * 0.10),

                // registration logic
                RoundedButton(
                    text: "Sign In",
                    color: orangePrimary,
                    press: () async {
                      RegisterUserRequest object = RegisterUserRequest(
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text);

                      try {
                        await _userService.registerUser(object).then((value) {
                          SnackBar snackBar = CustomSnackbar()
                              .displaySnacbar(value[0], value[1]);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);

                          if (value[0] == 201) {
                            Future.delayed(const Duration(seconds: 5));
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => const VerifyingAccount()));
                          }
                        });
                      } on Exception catch (e) {
                        SnackBar snackBar =
                            CustomSnackbar().displaySnacbar(0, e.toString());

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    }),

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

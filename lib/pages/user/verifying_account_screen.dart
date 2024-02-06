import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:watch_with_me/pages/landing_screen.dart';
import 'package:watch_with_me/pages/user/verified_account_screen.dart';
import 'package:watch_with_me/servicesAPI/user_service.dart';
import 'package:watch_with_me/utils/awesome_snackbar.dart';
import 'package:watch_with_me/utils/constants.dart';
import 'package:after_layout/after_layout.dart';

class VerifyingAccount extends StatefulWidget {
  final String usernameFromRegister;
  const VerifyingAccount({super.key, required this.usernameFromRegister});

  @override
  State<VerifyingAccount> createState() => _VerifyingAccountState();
}

class _VerifyingAccountState extends State<VerifyingAccount>
    with AfterLayoutMixin<VerifyingAccount> {
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;

  final _userService = UserService();

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
            color: bluePrimary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verify your",
                  style: TextStyle(
                      fontFamily: 'Chalet',
                      fontSize: deviceWidth * 0.12,
                      color: orangePrimary,
                      fontWeight: FontWeight.w300,
                      height: deviceHeight * 0.001),
                ),
                Text(
                  "account",
                  style: TextStyle(
                      height: deviceHeight * 0.001,
                      fontFamily: 'Chalet',
                      fontSize: deviceWidth * 0.12,
                      color: whitePrimary,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: deviceHeight * 0.2),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  LoadingAnimationWidget.discreteCircle(
                      color: orangePrimary,
                      size: deviceWidth * 0.35,
                      secondRingColor: whitePrimary,
                      thirdRingColor: orangePrimary),
                ]),
                SizedBox(height: deviceHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Waiting...",
                      style: TextStyle(
                          color: whitePrimary,
                          fontSize: deviceWidth * 0.06,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Chalet'),
                    )
                  ],
                ),
                SizedBox(height: deviceHeight * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "We will send you an e-mail to verify your account ",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: deviceWidth * 0.03,
                          color: whitePrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive an email?",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: deviceWidth * 0.03,
                          color: whitePrimary,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          enableResend ? _resendCode() : null;
                        },
                        child: Text(
                          "Request again",
                          style: TextStyle(
                              fontFamily: "Chalet",
                              color: enableResend ? whitePrimary : Colors.grey,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'after $secondsRemaining seconds',
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: deviceWidth * 0.03,
                        color: whitePrimary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    try {
      _userService
          .getUserActivationStatus(widget.usernameFromRegister)
          .then((value) {
        if (value[0] == 200 && value[1] == true) {
          sleep(const Duration(seconds: 2));
          // removes all previous pages
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const VerifiedAccount()),
            (Route<dynamic> route) => false,
          );
        } else if (value[0] == 404) {
          SnackBar snackBar = CustomSnackbar().displaySnacbar(0, value[1]);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          sleep(const Duration(seconds: 5));

          // removes all previous pages
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LandingScreen()),
            (Route<dynamic> route) => false,
          );
        }
      });
    } on Exception catch (e) {
      SnackBar snackBar = CustomSnackbar().displaySnacbar(0, e.toString());

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }
}

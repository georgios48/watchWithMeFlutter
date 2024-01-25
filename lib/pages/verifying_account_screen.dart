import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:watch_with_me/utils/constants.dart';

class VerifyingAccount extends StatefulWidget {
  const VerifyingAccount({super.key});

  @override
  State<VerifyingAccount> createState() => _VerifyingAccountState();
}

class _VerifyingAccountState extends State<VerifyingAccount> {
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
                        onPressed: () {},
                        child: const Text(
                          "Request again",
                          style: TextStyle(
                              fontFamily: "Chalet",
                              color: whitePrimary,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:watch_with_me/components/rounded_button.dart';
import 'package:watch_with_me/utils/constants.dart';

class VerifiedAccount extends StatefulWidget {
  const VerifiedAccount({super.key});

  @override
  State<VerifiedAccount> createState() => _VerifiedAccountState();
}

class _VerifiedAccountState extends State<VerifiedAccount> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verify your",
                  style: TextStyle(
                      fontFamily: 'Chalet',
                      fontSize: deviceWidth * 0.12,
                      color: whitePrimary,
                      fontWeight: FontWeight.w300,
                      height: deviceHeight * 0.001),
                ),
                Text(
                  "account",
                  style: TextStyle(
                      height: deviceHeight * 0.001,
                      fontFamily: 'Chalet',
                      fontSize: deviceWidth * 0.12,
                      color: orangePrimary,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: deviceHeight * 0.2),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset('assets/doneIcon.png')]),
                SizedBox(height: deviceHeight * 0.2),
                RoundedButton(
                    text: "Get Started", color: orangePrimary, press: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

class BlurryTextFieldDialog extends StatelessWidget {
  final String title;
  final TextEditingController textController;
  final VoidCallback continueCallBack;
  final String textFieldHintText;
  final bool hideText;

  const BlurryTextFieldDialog(
      {super.key,
      required this.title,
      required this.textController,
      required this.continueCallBack,
      required this.textFieldHintText,
      this.hideText = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(title,
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              )),
          content: TextField(
            controller: textController,
            obscureText: hideText,
            autocorrect: false,
            decoration: InputDecoration(hintText: textFieldHintText),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Continue"),
              onPressed: () {
                continueCallBack();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}

class BlurryTwoTextFieldDialog extends StatelessWidget {
  final String title;
  final TextEditingController firstTextController;
  final TextEditingController secondTextController;
  final VoidCallback continueCallBack;
  final String firstTextFieldHintText;
  final String secondTextFieldHintText;
  final bool firstHideText;
  final bool secondHideText;

  const BlurryTwoTextFieldDialog(
      {super.key,
      required this.title,
      required this.firstTextController,
      required this.secondTextController,
      required this.continueCallBack,
      required this.firstTextFieldHintText,
      required this.secondTextFieldHintText,
      this.firstHideText = false,
      this.secondHideText = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(title,
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              )),
          content: SizedBox(
            height: size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: firstTextController,
                  obscureText: firstHideText,
                  autocorrect: false,
                  decoration: InputDecoration(hintText: firstTextFieldHintText),
                ),
                TextField(
                  controller: secondTextController,
                  obscureText: secondHideText,
                  autocorrect: false,
                  decoration:
                      InputDecoration(hintText: secondTextFieldHintText),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Continue"),
              onPressed: () {
                continueCallBack();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}

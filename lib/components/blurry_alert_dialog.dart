import 'dart:ui';
import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback continueCallBack;

  const BlurryDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.continueCallBack});

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
          content: Text(content,
              style: TextStyle(
                fontSize: size.width * 0.03,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              )),
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

import 'dart:ui';
import 'package:flutter/material.dart';

class BlurryDialogWithThumbnailImage extends StatelessWidget {
  final String title;
  final Image content;
  final VoidCallback continueCallBack;

  const BlurryDialogWithThumbnailImage(
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
          content: content,
          actions: <Widget>[
            TextButton(
              child: const Text("Play"),
              onPressed: () {
                continueCallBack();
                Navigator.of(context).pop();
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

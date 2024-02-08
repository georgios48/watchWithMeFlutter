import 'package:flutter/material.dart';
import 'package:watch_with_me/utils/constants.dart';

class RoundBorderedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color fillColor, textColor, borderColor;
  const RoundBorderedButton(
      {super.key,
      required this.text,
      required this.press,
      this.fillColor = bluePrimary,
      this.textColor = whitePrimary,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // ignore: sized_box_for_whitespace
    return Container(
      width: size.width * 0.8,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: fillColor,
            side: BorderSide(width: 2, color: borderColor),
            padding: const EdgeInsets.all(10),
            foregroundColor: fillColor),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              fontSize: size.width * 0.05,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: textColor),
        ),
      ),
    );
  }
}

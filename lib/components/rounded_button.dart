import 'package:flutter/material.dart';
import 'package:watch_with_me/utils/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoundedButton(
      {super.key,
      required this.text,
      required this.press,
      this.color = bluePrimary,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // ignore: sized_box_for_whitespace
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
            onPressed: press,
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: whitePrimary),
                )
              ],
            )),
      ),
    );
  }
}

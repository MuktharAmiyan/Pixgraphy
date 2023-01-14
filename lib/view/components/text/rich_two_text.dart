import 'package:flutter/material.dart';

class RichtwoText extends StatelessWidget {
  final String text1;
  final String text2;
  final TextStyle? text1Style;
  final TextStyle? text2Style;
  const RichtwoText(
      {super.key,
      required this.text1,
      required this.text2,
      this.text1Style,
      this.text2Style});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$text1  ",
        style: text1Style,
        children: [
          TextSpan(
            text: text2,
            style: text2Style,
          )
        ],
      ),
    );
  }
}

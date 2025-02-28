import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String variant;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;

  // Constructor
  CustomText({
    required this.text,
    required this.variant,
    this.color = Colors.black,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = _getTextStyle(variant);

    return Text(
      text,
      style: style.copyWith(color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  TextStyle _getTextStyle(String variant) {
    switch (variant) {
      case 'title':
        return TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        );
      case 'body':
        return TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        );
      case 'label':
        return TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        );
      default:
        return TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        );
    }
  }
}

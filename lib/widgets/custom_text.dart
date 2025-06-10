import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String variant;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;

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

      maxLines: null, // 제한 없음
      overflow: TextOverflow.visible, // 또는 제거
      softWrap: true, // 자동 줄바꿈 허용
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
      case 'label1bold':
        return TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        );
      case 'label2':
        return TextStyle(
          fontSize: 14.0,
          height: 1.4,
          fontWeight: FontWeight.w400,
        );
      case 'label3':
        return TextStyle(
          fontSize: 14.0,
          height: 1.4,
          fontWeight: FontWeight.w400,
        );

      //
      case 'h3':
        return TextStyle(
          fontSize: 32.0,
          height: 1.3,
          fontWeight: FontWeight.w700,
        );
      case 'h4':
        return TextStyle(
          fontSize: 24.0,
          height: 1.35,
          fontWeight: FontWeight.w700,
        );
      case 'h5':
        return TextStyle(
          fontSize: 20.0,
          height: 1.4,
          fontWeight: FontWeight.w700,
        );
      case 'label1':
        return TextStyle(
          fontSize: 16.0,
          height: 1.5,
          fontWeight: FontWeight.normal,
        );
      default:
        return TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        );
    }
  }
}

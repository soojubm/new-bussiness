import 'package:flutter/material.dart';

const double fontSize = 14.0;
const double borderRadius = 4.0;

class CustomFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomFilledButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: _buttonStyle(context),
      child: Text(text),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primaryColor),
      minimumSize: MaterialStateProperty.all(Size(120.0, 48.0)),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: fontSize,
          // fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      elevation: MaterialStateProperty.all(2.0),
    );
  }
}

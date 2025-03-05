import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';

class CustomButtonGroup extends StatelessWidget {
  final String firstButtonText;
  final String secondButtonText;
  final VoidCallback onFirstButtonPressed;
  final VoidCallback onSecondButtonPressed;

  CustomButtonGroup({
    required this.firstButtonText,
    required this.secondButtonText,
    required this.onFirstButtonPressed,
    required this.onSecondButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          text: firstButtonText,
          onPressed: onFirstButtonPressed,
        ),
        CustomButton(
          text: secondButtonText,
          onPressed: onSecondButtonPressed,
        ),
      ],
    );
  }
}

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
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.rtl,
      spacing: 8,
      children: [
        CustomButton(
          variant: 'filled',
          text: firstButtonText,
          onPressed: onFirstButtonPressed,
        ),
        CustomButton(
          variant: 'secondary',
          text: secondButtonText,
          onPressed: onSecondButtonPressed,
        ),
      ],
    );
  }
}

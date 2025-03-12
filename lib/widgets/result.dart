import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

class Result extends StatelessWidget {
  final String title;
  final String description;

  Result({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
        spacing: 8,
        children: [
          CustomText(variant: 'title', text: title),
          CustomText(variant: 'body', text: description),
          SizedBox(height: 20),
          CustomButton(
            variant: 'filled',
            text: 'text',
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}

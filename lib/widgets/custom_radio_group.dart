import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_radio.dart';

class CustomRadioGroup extends StatelessWidget {
  final List<String> options;
  final int selectedValue;
  final ValueChanged<int> onChanged;

  CustomRadioGroup({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        options.length,
        (index) => GestureDetector(
          onTap: () {
            onChanged(index);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomRadio(
                value: selectedValue == index,
                onChanged: (_) {
                  onChanged(index);
                },
              ),
              SizedBox(width: 10),
              Text(
                options[index],
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

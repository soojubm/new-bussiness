import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_text.dart'; // Assuming CustomText is correctly defined here

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;

  const CustomCheckbox({
    super.key, // Added super.key for best practice
    required this.value,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
                // 필요에 따라 체크박스 배경색을 추가할 수 있습니다.
                // color: value ? Color(0xFFFF938F).withOpacity(0.2) : Colors.transparent,
                // 모서리를 둥글게 하고 싶다면 borderRadius를 추가할 수 있습니다.
                // borderRadius: BorderRadius.circular(4.0),
                ),
            child: Center(
              child: Icon(
                Icons.check,
                size: 18.0,
                color: value ? Color(0xFFFF938F) : Colors.grey,
              ),
            ),
          ),
          if (label != null) ...[
            SizedBox(width: 8.0),
            Text(
              label!,
              style: TextStyle(
                color: Colors.black, // Set a default text color for the label
                fontSize: 16.0,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

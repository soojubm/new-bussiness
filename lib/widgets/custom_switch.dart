import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;

  CustomSwitch({
    required this.value,
    required this.onChanged,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Switch(
      value: value,
      onChanged: onChanged,
      // inactiveThumbColor: Colors.grey, // 비활성화된 상태의 색상
      // inactiveTrackColor: Colors.black12, // 비활성화된 트랙 색상
      activeColor: Colors.white,
      activeTrackColor: primaryColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 크기 조정
    );
  }
}

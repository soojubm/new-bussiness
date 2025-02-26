import 'package:flutter/material.dart';

enum ButtonSize { small, medium }

// enum 사용으로 직관적, 가독적(? ㅋㅋ 가독성 높일 수 있네)
// 기본값으로 설정하는 방법

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final ButtonSize size;

  const CustomIconButton(
      {required this.icon,
      required this.onPressed,
      this.tooltip,
      this.size = ButtonSize.medium});

  @override
  Widget build(BuildContext context) {
    double buttonDimension;
    double iconDimension;

    switch (size) {
      case ButtonSize.small:
        buttonDimension = 40.0;
        iconDimension = 20.0;
        break;
      case ButtonSize.medium:
        buttonDimension = 60.0;
        iconDimension = 30.0;
        break;
    }

    return Container(
      width: buttonDimension,
      height: buttonDimension,
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.blue,
          size: iconDimension,
        ),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}

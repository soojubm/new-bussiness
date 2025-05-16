import 'package:flutter/material.dart';

enum ButtonSize { small, medium }

// enum 사용으로 직관적, 가독적(? ㅋㅋ 가독성 높일 수 있네)
// 기본값으로 설정하는 방법

class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final ButtonSize size;
  final Color? backgroundColor;

  const CustomIconButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = ButtonSize.medium,
    this.backgroundColor,
  });

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
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: SizedBox(
          width: iconDimension,
          height: iconDimension,
          child: Center(child: icon),
        ),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}

import 'package:flutter/material.dart';

const double fontSize = 14.0;
const double borderRadius = 4.0;

class CustomButton extends StatelessWidget {
  final String? size;
  final String text;
  final VoidCallback onPressed;
  final String variant;
  final bool isFullWidth;

  const CustomButton({
    this.size = 'medium',
    this.variant = 'filled',
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
  });

  double _getButtonHeight() {
    switch (size) {
      case 'small':
        return 40.0;
      case 'medium':
      default:
        return 48.0; // medium 크기 (기본값)
    }
  }

  Color _getButtonBackgroundColor() {
    switch (variant) {
      case 'filled':
        return Colors.blue;
      case 'secondary':
        return Colors.black;
      default:
        return Colors.blue;
    }
  }

  Color _getBorderColor() {
    switch (variant) {
      case 'filled':
        return Colors.transparent;
      case 'secondary':
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: isFullWidth ? double.infinity : null,
        child: RawMaterialButton(
          child:
              Text(text, style: TextStyle(fontSize: 14.0, color: Colors.white)),
          onPressed: onPressed,
          // style: _buttonStyle(context),
          constraints: BoxConstraints(
            minHeight: _getButtonHeight(),
            maxHeight: _getButtonHeight(),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          fillColor: _getButtonBackgroundColor(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: _getBorderColor(), width: 1),
          ),
        ));
  }
}

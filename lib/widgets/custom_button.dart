import 'package:flutter/material.dart';

const double fontSize = 14.0;
const double borderRadius = 100.0;

class CustomButton extends StatelessWidget {
  final String? size;
  final String text;
  final VoidCallback onPressed;
  final String variant;
  final String style;
  final bool isFullWidth;
  final Widget? leadingIcon;
  final bool disabled; // ✅ 추가된 파라미터

  const CustomButton({
    this.size = 'medium',
    this.variant = 'filled',
    this.style = 'primary',
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.leadingIcon,
    this.disabled = false, // ✅ 기본값 false
  });

  double _getButtonHeight() {
    switch (size) {
      case 'small':
        return 40.0;
      case 'medium':
        return 48.0;
      case 'large':
        return 64.0;
      default:
        return 48.0;
    }
  }

  Color _getButtonBackgroundColor() {
    if (disabled) return Colors.grey.shade800; // ✅ 비활성 배경색
    switch (variant) {
      case 'primary':
        return Color(0xFF373C42);
      case 'secondary':
        return Color(0xFFF89491);
      case 'secondary2':
        return Color(0xFFFDE3E2);
      default:
        return Color(0xFF373C42);
    }
  }

  Color _getTextColor() {
    if (disabled) return Colors.grey.shade400; // ✅ 비활성 텍스트 색상
    return leadingIcon != null ? Colors.black : Colors.white;
  }

  Color _getBorderColor() {
    if (disabled) return Colors.transparent;
    switch (variant) {
      case 'filled':
      case 'secondary':
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.4 : 1.0, // ✅ 비활성화 시 흐리게
      child: Container(
        width: isFullWidth ? double.infinity : null,
        child: RawMaterialButton(
          onPressed: disabled ? null : onPressed, // ✅ 터치 비활성화
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon!,
                SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: leadingIcon != null ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
          constraints: BoxConstraints(
            minHeight: _getButtonHeight(),
            maxHeight: _getButtonHeight(),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          fillColor: _getButtonBackgroundColor(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: _getBorderColor(), width: 1),
          ),
        ),
      ),
    );
  }
}

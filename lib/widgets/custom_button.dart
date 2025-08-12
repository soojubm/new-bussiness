import 'package:flutter/material.dart';

const double fontSize = 14.0;
const double borderRadius = 100.0;

class CustomButton extends StatelessWidget {
  final String? size;
  final String? text; // for 이미지로 대체하는 텍스트
  final Widget? image;
  final VoidCallback onPressed;
  final String variant;
  final String style;
  final bool isFullWidth;
  final Widget? leadingIcon;
  final bool disabled;

  const CustomButton({
    this.size = 'medium',
    this.variant = 'filled',
    this.style = 'primary',
    this.text,
    this.image,
    required this.onPressed,
    this.isFullWidth = false,
    this.leadingIcon,
    this.disabled = false,
  })  : assert(
          (text != null && image == null) || (text == null && image != null),
          'text 또는 image 중 하나만 제공해야 합니다.',
        ),
        assert(onPressed != null, 'onPressed는 null일 수 없습니다');

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
    if (disabled) return Color(0xFFFDD8D7); // ✅ 비활성 배경색
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

  double _getFontSize() {
    switch (size) {
      case 'small':
        return 12.0;
      case 'medium':
        return 14.0;
      case 'large':
        return 18.0;
      default:
        return 14.0;
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
              if (image != null)
                image!
              else if (text != null)
                Text(
                  text!,
                  style: TextStyle(
                    fontSize: _getFontSize(), // ← 여기에 적용
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'custom_text.dart'; // CustomText가 정의된 파일 import

class TypingText extends StatefulWidget {
  final String text;
  final Duration speed;
  final Function(double progress)? onProgress;

  // CustomText 관련 추가 파라미터
  final String variant;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;

  const TypingText({
    required this.text,
    this.speed = const Duration(milliseconds: 25),
    this.onProgress,
    this.variant = 'h3', // 기본 스타일
    this.color = Colors.black,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.visible,
    Key? key,
  }) : super(key: key);

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  String _visibleText = '';
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _visibleText += widget.text[_currentIndex];
          _currentIndex++;
        });
        widget.onProgress?.call(_currentIndex / widget.text.length);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: _visibleText,
      variant: widget.variant,
      color: widget.color,
      textAlign: widget.textAlign,
      overflow: widget.overflow,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

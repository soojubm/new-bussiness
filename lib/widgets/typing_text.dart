import 'dart:async'; // for Timer
import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  final String text;
  final Duration speed;
  final Function(double progress)? onProgress;
  final TextStyle? textStyle; // 스타일 파라미터 추가

  const TypingText({
    required this.text,
    this.speed = const Duration(milliseconds: 25),
    this.onProgress,
    this.textStyle =
        const TextStyle(fontSize: 32, fontWeight: FontWeight.bold), // 기본 스타일
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
        if (widget.onProgress != null) {
          widget.onProgress!(_currentIndex / widget.text.length);
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _visibleText,
      style: widget.textStyle, // 스타일 적용
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

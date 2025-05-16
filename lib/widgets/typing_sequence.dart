import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';

class TypingSequence extends StatefulWidget {
  final Widget? firstWidget;
  final Widget? secondWidget;
  final Widget? thirdWidget;
  final Widget? fourthWidget;

  const TypingSequence({
    Key? key,
    this.firstWidget,
    this.secondWidget,
    this.thirdWidget,
    this.fourthWidget,
  }) : super(key: key);

  @override
  State<TypingSequence> createState() => _TypingSequenceState();
}

class _TypingSequenceState extends State<TypingSequence> {
  bool showSecondWidget = false;
  bool showThirdWidget = false;
  bool showFourthWidget = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.firstWidget != null)
          _wrapWithProgress(widget.firstWidget!, () {
            if (widget.secondWidget != null && !showSecondWidget) {
              setState(() {
                showSecondWidget = true;
              });
            } else if (widget.thirdWidget != null && !showThirdWidget) {
              setState(() {
                showThirdWidget = true;
              });
            } else if (widget.fourthWidget != null && !showFourthWidget) {
              setState(() {
                showFourthWidget = true;
              });
            }
          }),
        if (widget.firstWidget != null) const SizedBox(height: 8),
        if (showSecondWidget && widget.secondWidget != null) ...[
          _wrapWithProgress(widget.secondWidget!, () {
            if (widget.thirdWidget != null && !showThirdWidget) {
              setState(() {
                showThirdWidget = true;
              });
            } else if (widget.fourthWidget != null && !showFourthWidget) {
              setState(() {
                showFourthWidget = true;
              });
            }
          }),
          const SizedBox(height: 24),
        ],
        if (showThirdWidget && widget.thirdWidget != null) ...[
          _wrapWithProgress(widget.thirdWidget!, () {
            if (widget.fourthWidget != null && !showFourthWidget) {
              setState(() {
                showFourthWidget = true;
              });
            }
          }),
          const SizedBox(height: 24),
        ],
        if (showFourthWidget && widget.fourthWidget != null) ...[
          widget.fourthWidget!,
          const SizedBox(height: 24),
        ],
      ],
    );
  }

  Widget _wrapWithProgress(Widget widget, VoidCallback onProgressDone) {
    if (widget is TypingText) {
      return TypingText(
        key: widget.key,
        text: widget.text,
        speed: widget.speed,
        variant: widget.variant,
        color: widget.color,
        textAlign: widget.textAlign,
        overflow: widget.overflow,
        onProgress: (progress) {
          // 원래 onProgress 콜백도 유지
          widget.onProgress?.call(progress);
          if (progress > 0.85) {
            onProgressDone();
          }
        },
      );
    }
    return widget;
  }
}

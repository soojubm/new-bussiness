import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';

class TypingSequenceWidget extends StatefulWidget {
  final String firstText;
  final Widget secondWidget;
  final Widget thirdWidget;
  final Widget fourthWidget;

  const TypingSequenceWidget({
    Key? key,
    required this.firstText,
    required this.secondWidget,
    required this.thirdWidget,
    required this.fourthWidget,
  }) : super(key: key);

  @override
  State<TypingSequenceWidget> createState() => _TypingSequenceWidgetState();
}

class _TypingSequenceWidgetState extends State<TypingSequenceWidget> {
  bool showSecondWidget = false;
  bool showThirdWidget = false;
  bool showFourthWidget = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TypingText(
          text: widget.firstText,
          textStyle: const TextStyle(
            fontSize: 24.0,
            height: 1.35,
            fontWeight: FontWeight.bold,
          ),
          onProgress: (progress) {
            if (progress > 0.85 && !showSecondWidget) {
              setState(() {
                showSecondWidget = true;
              });
            }
          },
        ),
        const SizedBox(height: 8),
        if (showSecondWidget) ...[
          _wrapWithProgress(widget.secondWidget, () {
            if (!showThirdWidget) {
              setState(() {
                showThirdWidget = true;
              });
            }
          }),
          const SizedBox(height: 24),
        ],
        if (showThirdWidget) ...[
          _wrapWithProgress(widget.thirdWidget, () {
            if (!showFourthWidget) {
              setState(() {
                showFourthWidget = true;
              });
            }
          }),
          const SizedBox(height: 24),
        ],
        if (showFourthWidget) ...[
          widget.fourthWidget,
          const SizedBox(height: 24),
        ],
      ],
    );
  }

  Widget _wrapWithProgress(Widget widget, VoidCallback onProgressDone) {
    if (widget is TypingText) {
      return TypingText(
        text: widget.text,
        textStyle: widget.textStyle,
        onProgress: (progress) {
          if (progress > 0.85) {
            onProgressDone();
          }
        },
      );
    }
    return widget;
  }
}

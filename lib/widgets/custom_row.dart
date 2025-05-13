import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final List<Widget> children;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment mainAxisAlignment;
  final double spacing;
  final TextDirection textDirection;

  CustomRow(
      {required this.children,
      this.backgroundColor = Colors.transparent,
      this.padding = const EdgeInsets.all(0),
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.spacing = 0,
      this.textDirection = TextDirection.ltr});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        textDirection: textDirection,
        spacing: spacing,
        children: children,
      ),
    );
  }
}

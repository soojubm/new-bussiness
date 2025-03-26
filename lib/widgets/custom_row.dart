import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final List<Widget> children;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment mainAxisAlignment;

  CustomRow({
    required this.children,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      ),
    );
  }
}

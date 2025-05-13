import 'package:flutter/material.dart';

class CustomColumn extends StatelessWidget {
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;

  CustomColumn({
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(0),
    required this.children,
    this.spacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          spacing: spacing,
          children: children,
        ),
      ),
    );
  }
}

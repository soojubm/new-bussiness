import 'package:flutter/material.dart';

class ActionList extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;

  const ActionList({
    Key? key,
    required this.children,
    this.spacing = 8.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: _buildSpacedChildren(),
    );
  }

  List<Widget> _buildSpacedChildren() {
    // spacing 값을 기준으로 children 사이에 SizedBox 삽입
    final List<Widget> spaced = [];
    for (int i = 0; i < children.length; i++) {
      spaced.add(children[i]);
      if (i != children.length - 1) {
        spaced.add(SizedBox(height: spacing));
      }
    }
    return spaced;
  }
}

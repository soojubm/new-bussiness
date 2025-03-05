import 'package:flutter/material.dart';

class CustomInputChip extends StatelessWidget {
  final String label;

  CustomInputChip({
    required this.label,
  });

  int inputs = 3;
  // int? selectedIndex;

  // void _handleChipSelected(bool selected, int index) {
  //   setState(() {
  //     if (selectedIndex == index) {
  //       selectedIndex = null;
  //     } else {
  //       selectedIndex = index;
  //     }
  //   });
  // }

  // void _handleChipDeleted() {
  //   setState(() {
  //     if (inputs > 0) {
  //       inputs--;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(label),
      selected: true,
      // selected: selectedIndex == index,
      // onSelected: (bool selected) {
      //   _handleChipSelected(selected, index);
      // },
      // onDeleted: _handleChipDeleted,
    );
  }
}

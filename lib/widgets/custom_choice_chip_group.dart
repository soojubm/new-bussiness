import 'package:flutter/material.dart';

// 단독으로 사용하는 경우는 없어서, 단일 CustomChip을 사용하지 않는 게 좋을까?

class CustomChoiceChipGroup extends StatelessWidget {
  final int selectedIndex;
  final List<String> chipLabels;
  final ValueChanged<int> onSelectionChanged; // 선택 변경 이벤트

  CustomChoiceChipGroup({
    required this.selectedIndex,
    required this.chipLabels,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: chipLabels
          .asMap()
          .map((index, label) {
            return MapEntry(
              index,
              ChoiceChip(
                label: Text(label),
                selected: selectedIndex == index,
                onSelected: (bool selected) {
                  onSelectionChanged(index);
                },
                selectedColor: Colors.blue,
                labelStyle: TextStyle(
                  color: selectedIndex == index ? Colors.white : Colors.black,
                ),
              ),
            );
          })
          .values
          .toList(),
    );
  }
}

// import 'package:flutter/material.dart';

// class CustomFilterChipGroup extends StatefulWidget {
//   final List<String> filters;
//   final List<String> selectedFilters;
//   final ValueChanged<List<String>> onSelectionChanged;

//   CustomFilterChipGroup({
//     required this.filters,
//     required this.selectedFilters,
//     required this.onSelectionChanged,
//   });

//   @override
//   _CustomFilterChipGroupState createState() => _CustomFilterChipGroupState();
// }

// class _CustomFilterChipGroupState extends State<CustomFilterChipGroup> {
//   late List<String> selectedFilters;

//   @override
//   void initState() {
//     super.initState();
//     // 초기 selectedFilters 값 설정
//     selectedFilters = List.from(widget.selectedFilters);
//   }

//   bool isSelected(String filter) {
//     return selectedFilters.contains(filter);
//   }

//   // 선택을 토글하는 함수
//   void toggleSelection(String filter) {
//     setState(() {
//       if (isSelected(filter)) {
//         selectedFilters.remove(filter);
//       } else {
//         selectedFilters.add(filter);
//       }
//     });
//     // 부모 위젯에게 선택 변경 사항 전달
//     widget.onSelectionChanged(selectedFilters);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 10.0,
//       children: widget.filters.map((filter) {
//         return FilterChip(
//           label: Text(filter),
//           selected: isSelected(filter),
//           onSelected: (isSelected) {
//             toggleSelection(filter);
//           },
//           selectedColor: Colors.blueAccent,
//           backgroundColor: Colors.grey[300],
//           shape: StadiumBorder(),
//           labelStyle: TextStyle(
//             color: isSelected(filter) ? Colors.white : Colors.black,
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomFilterChipGroup extends StatelessWidget {
  final List<String> filters;
  final List<String> selectedFilters;
  final ValueChanged<List<String>> onSelectionChanged;

  CustomFilterChipGroup({
    required this.filters,
    required this.selectedFilters,
    required this.onSelectionChanged,
  });

  // 선택 여부를 확인하는 함수
  bool isSelected(String filter) {
    return selectedFilters.contains(filter);
  }

  // 선택을 토글하는 함수
  void toggleSelection(String filter) {
    if (isSelected(filter)) {
      onSelectionChanged(selectedFilters..remove(filter));
    } else {
      onSelectionChanged(selectedFilters..add(filter));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: filters.map((filter) {
        return FilterChip(
          label: Text(filter),
          selected: isSelected(filter),
          onSelected: (isSelected) {
            toggleSelection(filter);
          },
          selectedColor: Colors.blueAccent,
          backgroundColor: Colors.grey[300],
          shape: StadiumBorder(),
          labelStyle: TextStyle(
            color: isSelected(filter) ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
  final String label;
  // final bool value;
  // final ValueChanged<bool> onChanged;

  CustomChip({required this.label});

  @override
  _CustomChipState createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool _isSelected = false; // Chip의 선택 상태를 관리할 변수

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return RawChip(
      // avatar: CircleAvatar(
      //   backgroundColor: Colors.grey.shade800,
      //   child: const Text('AB'),
      // ),
      label: Text(widget.label),

      // deleteIcon: Icon(Icons.delete), // The delete icon
      // onDeleted: () {
      //   // Action to perform when the delete icon is clicked
      //   print("Chip deleted!");
      // },

      selected: _isSelected, // 선택된 상태인지 여부
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected; // 선택 상태 변경
        });
      },
      selectedColor: Colors.blue, // 선택된 상태에서의 배경색
      labelStyle: TextStyle(
        color: _isSelected ? Colors.white : Colors.black, // 선택 상태에 따른 글자색 변경
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final size = 20.0;
  //   final activeColor = Colors.blue;
  //   final inactiveColor = Colors.grey;

  //   return GestureDetector(
  //     onTap: () {
  //       onChanged(!value); // 라디오 버튼 클릭 시 상태 변경
  //     },
  //     child: Container(
  //       width: size,
  //       height: size,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: value ? activeColor : Colors.white, // 선택 상태에 따른 색상
  //         border: Border.all(
  //           color: value ? activeColor : inactiveColor, // 테두리 색상
  //           width: 2.0,
  //         ),
  //       ),
  //       child: value
  //           ? Center(
  //               child: Container(
  //                 width: size / 2,
  //                 height: size / 2,
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   color: Colors.white, // 선택된 상태의 내부 원
  //                 ),
  //               ),
  //             )
  //           : Container(), // 선택되지 않은 경우 내부 원을 표시하지 않음
  //     ),
  //   );
  // }
}

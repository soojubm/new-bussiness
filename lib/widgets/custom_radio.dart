import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomRadio({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Radio<bool>(
      value: true, // 라디오 버튼의 선택값
      groupValue: value, // 라디오 그룹 내에서 선택된 값
      onChanged: (bool? newValue) {
        if (newValue != null) {
          onChanged(newValue); // 상태 변경 시 onChanged 호출
        }
      },
      activeColor: Colors.blue,
      // inactiveThumbColor: Colors.grey,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 클릭 범위 조정
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

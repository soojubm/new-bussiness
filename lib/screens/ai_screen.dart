import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_application_1/screens/ai_image_screen.dart';
import 'package:flutter_application_1/screens/ai_product_detail_screen.dart';
import 'package:flutter_application_1/screens/ai_text_screen.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/typing_sequence.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AIScreen extends StatefulWidget {
  @override
  _AIScreenState createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  // bool _showSecondWidget = false;
  // bool _showThirdWidget = false;
  // bool _showFourthWidget = false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    void _onSearch() {
      print('검색어: ${_controller.text}');
    }

    return Scaffold(
      appBar: CustomAppBar(
        variant: AppBarVariant.menu,
        title: 'AI',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // 알림 아이콘 클릭 시 동작
              print('알림 클릭됨');
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TypingSequence(
                        firstWidget: TypingText(
                          variant: 'h3',
                          text: '상품 이미지를 업로드해주세요.',
                        ),
                        secondWidget: TypingText(
                          variant: 'label1',
                          text: '상세페이지 제작을 위한 모든 것 \nAI가 도와드려요.',
                        ),
                        // SizedBox(height: 8),
                        // CustomText(
                        //   variant: 'label1',
                        //   text: '상세페이지 제작을 위한 모든 것 \nAI가 도와드려요.',
                        //   color: Color(0xFF5D5D5D),
                        // ),

                        // TODO buttonGroupWidget
                        thirdWidget: Column(
                          spacing: 8.0,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomButton(
                              variant: 'secondary',
                              size: 'medium',
                              text: 'AI 텍스트',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AiTextScreen()),
                                );
                              },
                            ),
                            CustomButton(
                              variant: 'secondary',
                              size: 'medium',
                              text: 'AI 이미지',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AIImageScreen()),
                                );
                              },
                            ),
                            CustomButton(
                              variant: 'secondary',
                              size: 'medium',
                              text: 'AI 상세페이지',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AiProductDetailScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//   String _formatTimestamp(DateTime timestamp) {
//     return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}'; // 시간 표시
//   }
// }


// lalyoutBuilder 샘플
// LayoutBuilder(
//   builder: (context, constraints) {
//     return Container(
//       width: constraints.maxWidth * 0.68, // 가로폭의 68%
//       child: GridView.count(
//         shrinkWrap: true,
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//         padding: const EdgeInsets.all(20),
//         children: <Widget>[
//           // 자식 위젯들
//         ],
//       ),
//     );
//   },
// )

              // AnimatedTextKit(
              //   animatedTexts: [
              //     TypewriterAnimatedText(
              //       '상품 이미지를 업로드해주세요.',
              //       speed: const Duration(milliseconds: 70),
              //     ),
              //   ],
              //   isRepeatingAnimation: false,
              //   onFinished: () {
              //     setState(() {
              //       _showSecondText = true;
              //     });
              //   },
              //   // totalRepeatCount: 4,
              //   // pause: const Duration(milliseconds: 1000),
              //   // displayFullTextOnTap: true,
              //   // stopPauseOnTap: true,
              //   // controller: myAnimatedTextController
              // ),
              // SizedBox(height: 8),
              // if (_showSecondText)
              //   AnimatedTextKit(
              //     animatedTexts: [
              //       TyperAnimatedText(
              //         '업로드한 이미지의 배경을 자동으로 제거해 드려요.',
              //     ],
              //     isRepeatingAnimation: false,
              //     onFinished: () {
              //       setState(() {
              //         _showButton = true;
              //       });
              //     },
              //   ),
              // else
              //   SizedBox(
              //     height: 30,
              //     child: AnimatedTextKit(
              //       animatedTexts: [
              //         TyperAnimatedText(
              //           '',
              //         ),
              //       ],
              //       isRepeatingAnimation: false,
              //       onFinished: () {
              //         setState(() {
              //           _showSecondText = true;
              //         });
              //       },
              //     ),
              //   ),

              // Spacer(), // 👈 남는 공간 밀어냄
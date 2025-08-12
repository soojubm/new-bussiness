import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/ai_image_screen.dart';
import 'package:flutter_application_1/screens/ai_product_detail_screen.dart';
import 'package:flutter_application_1/screens/ai_text_screen.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/typing_sequence.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class AIScreen extends StatefulWidget {
  @override
  _AIScreenState createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    String _reply = '';

    Uint8List? _imageBytes;
    String? _error;

    void _onSearch() {
      print('검색어: ${_controller.text}');
    }

    void showDebugDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('디버그 출력'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('닫기'),
            ),
          ],
        ),
      );
    }

    Future<void> sendMessage(String message) async {
      const fastapiUrl =
          'https://caeb-115-91-159-217.ngrok-free.app/generate-image'; // ⚠️ 실제 환경에서는 IP 주소로 변경
      final userId = 'test_user_001'; // 추후 Firebase UID로 교체

      try {
        final response = await http.post(
          Uri.parse(fastapiUrl),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
            'prompt': '고양이가 우주복을 입고 있는 이미지 생성해줘',
          },
        ).timeout(Duration(seconds: 200));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          String base64Str = data['image_base64'];

          // showDebugDialog(context, data.toString());

          setState(() {
            _reply = 'faf: ${response.body}';
            _imageBytes = base64Decode(base64Str);
          });
          // print('응답 데이터: $data');
          // setState(() {
          //   _reply = data;
          // });
        } else {
          // showDebugDialog(context, response.body.toString());

          setState(() {
            _reply = '서버 오류: ${response.statusCode}';
          });
        }
      } catch (e) {
        // showDebugDialog(context, e.toString());

        setState(() {
          _reply = '오류 발생: $e';
        });
      }
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
                  padding: const EdgeInsets.fromLTRB(
                      horizontalPadding, 16.0, horizontalPadding, 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TypingSequence(
                        firstWidget: TypingText(
                          variant: 'h3',
                          text: '무엇을 만들어 드릴까요?',
                          textAlign: TextAlign.center,
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => AiTextScreen()),
                                );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           const AiTextScreen()),
                                // );
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
                            Column(
                              children: [
                                TextField(
                                  controller: _controller,
                                  decoration:
                                      InputDecoration(labelText: '메시지 입력'),
                                ),
                                SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    sendMessage(_controller.text);
                                  },
                                  child: Text("전송"),
                                ),
                                SizedBox(height: 24),
                                Text(_imageBytes == null
                                    ? "이미지를 업로드해주세요."
                                    : "이미지 업로드 완료!"),
                                _imageBytes == null
                                    ? CircularProgressIndicator()
                                    : Image.memory(_imageBytes!),
                                Text("응답:"),
                                Container(
                                  child: Text(_reply),
                                ),
                              ],
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
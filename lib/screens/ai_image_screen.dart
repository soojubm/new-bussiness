import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ai_screen.dart';
import 'package:flutter_application_1/widgets/action_list.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/image_with_fallback.dart';
import 'package:flutter_application_1/widgets/typing_sequence.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart'; // 경로는 프로젝트에 맞게 조정

enum ButtonAction { removeBg, generateAI }

enum ButtonAction2 { saveImage, removeBg, generateAI }

class AIImageScreen extends StatefulWidget {
  @override
  _AIImageScreenState createState() => _AIImageScreenState();
}

class _AIImageScreenState extends State<AIImageScreen> {
  bool showSecondWidget = false;
  bool showThirdWidget = false;
  bool showFourthWidget = false;
  ButtonAction? selectedAction;
  ButtonAction2? selectedAction2;

  void _handleButtonClick(ButtonAction action) {
    setState(() {
      selectedAction = action;
    });

    if (action == ButtonAction.removeBg) {
      // 배경 제거 로직
      debugPrint("배경 제거 클릭됨");
    } else if (action == ButtonAction.generateAI) {
      // AI 이미지 생성 로직
      debugPrint("AI 이미지 생성 클릭됨");
    }
  }

  void _handleButtonClick2(ButtonAction2 action) {
    setState(() {
      selectedAction2 = action;
    });

    if (action == ButtonAction2.saveImage) {
      debugPrint("이미지 저장");
    } else if (action == ButtonAction2.removeBg) {
      debugPrint("배경 제거 클릭됨");
    } else if (action == ButtonAction2.generateAI) {
      debugPrint("AI 이미지 생성 클릭됨");
    }
  }

  // const _AIScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'AI 이미지',
        variant: AppBarVariant.up,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO
              SizedBox(height: 16),
              TypingSequence(
                firstWidget: TypingText(
                  variant: "h4",
                  text: '어떤 이미지를 만들어 드릴까요?',
                ),
                secondWidget: TypingText(
                  variant: "label1",
                  text: '상품 이미지만 올려주세요. \nAI가 자동으로 어울리는 배경을 만들어 드려요.',
                ),
                thirdWidget: Column(
                  spacing: 8.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                        variant: 'secondary',
                        size: 'medium',
                        text: '이미지 배경제거',
                        disabled: selectedAction == ButtonAction.generateAI,
                        onPressed: () =>
                            _handleButtonClick(ButtonAction.removeBg)),
                    CustomButton(
                      variant: 'secondary',
                      size: 'medium',
                      text: 'AI 이미지 생성',
                      disabled: selectedAction == ButtonAction.removeBg,
                      onPressed: () =>
                          _handleButtonClick(ButtonAction.generateAI),
                    ),
                  ],
                ),
              ),

              // CustomText(
              //   variant: 'label1',
              //   text: '상품 이미지만 올려주세요. \nAI가 자동으로 어울리는 배경을 만들어 드려요.',
              //   color: Color(0xFF5D5D5D),
              // ),

              // 배경제거
              if (selectedAction == ButtonAction.removeBg) ...[
                // 텍스트 영역
                SizedBox(height: 16),
                TypingSequence(
                  firstWidget: TypingText(
                    variant: "h4",
                    text: '상품 이미지를 업로드해주세요.',
                  ),
                  secondWidget: TypingText(
                    variant: "label1",
                    text: '업로드한 이미지의 배경을 자동으로 제거해 드려요.',
                  ),
                  thirdWidget: ImageWithFallback(
                    imageUrl: 'assets/images/image_fallback.svg',
                    fallbackImageUrl: 'assets/images/image_fallback.svg',
                    loadingImageAsset: 'assets/images/image_fallback.svg',
                  ),
                  fourthWidget: ActionList(
                    children: [
                      CustomButton(
                        variant: 'secondary2',
                        size: 'medium',
                        text: '이미지 저장',
                        disabled: selectedAction == ButtonAction2.generateAI,
                        onPressed: () =>
                            _handleButtonClick2(ButtonAction2.saveImage),
                        leadingIcon: SvgPicture.asset(
                          '/icons/image_save.svg',
                          width: 24,
                          height: 24,
                          // colorFilter: Color(0xFFDE3B35)),
                        ),
                      ),
                      CustomButton(
                        variant: 'secondary2',
                        size: 'medium',
                        text: '다른 이미지 배경제거',
                        disabled: selectedAction == ButtonAction2.generateAI,
                        onPressed: () =>
                            _handleButtonClick2(ButtonAction2.removeBg),
                        leadingIcon: SvgPicture.asset(
                          '/icons/background_remove.svg',
                          width: 24,
                          height: 24,
                          // colorFilter: Color(0xFFDE3B35)),
                        ),
                      ),
                      CustomButton(
                        variant: 'secondary2',
                        size: 'medium',
                        text: 'AI 이미지 생성',
                        disabled: selectedAction == ButtonAction2.generateAI,
                        onPressed: () =>
                            _handleButtonClick2(ButtonAction2.generateAI),
                        leadingIcon: SvgPicture.asset(
                          '/icons/ai_generate.svg',
                          width: 24,
                          height: 24,
                          // colorFilter: Color(0xFFDE3B35)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (selectedAction == ButtonAction.generateAI) ...[
                SizedBox(height: 16),
                TypingSequence(
                  firstWidget: TypingText(
                    variant: "h4",
                    text: '상품 이미지를 업로드해주세요.',
                  ),
                  secondWidget: TypingText(
                    variant: "label1",
                    text: '업로드한 이미지의 배경을 자동으로 제거해 드려요.',
                  ),
                  thirdWidget: ActionList(
                    children: [
                      CustomButton(
                        variant: 'secondary2',
                        size: 'medium',
                        text: '예시사진 업로드',
                        onPressed: () => {},
                        leadingIcon: SvgPicture.asset(
                          '/icons/image_save.svg',
                          width: 24,
                          height: 24,
                          // colorFilter: Color(0xFFDE3B35)),
                        ),
                      ),
                      CustomButton(
                        variant: 'secondary2',
                        size: 'medium',
                        text: '컨셉 직접 설명',
                        onPressed: () => {},
                        leadingIcon: SvgPicture.asset(
                          '/icons/background_remove.svg',
                          width: 24,
                          height: 24,
                          // colorFilter: Color(0xFFDE3B35)),
                        ),
                      ),
                      CustomButton(
                        variant: 'secondary2',
                        size: 'medium',
                        text: '어울리는 컨셉 추천',
                        onPressed: () => {},
                        leadingIcon: SvgPicture.asset(
                          '/icons/ai_generate.svg',
                          width: 24,
                          height: 24,
                          // colorFilter: Color(0xFFDE3B35)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // SizedBox(height: 16),
              // if (showThirdWidget) ...[
              //   Row(
              //     spacing: 8,
              //     children: [
              //       TypingText(
              //         text: 'AI가 이미지를 만들고 있어요. \n약간의 시간이 소요됩니다.',
              //         onProgress: (progress) {
              //           if (progress > 0.85 && !showFourthWidget) {
              //             setState(() {
              //               showFourthWidget = true;
              //             });
              //           }
              //         },
              //       ),
              //     ],
              //   ),
              //   SizedBox(height: 24),
              // ],

              // if (showFourthWidget) ...[
              //   ImageWithFallback(
              //     imageUrl: 'assets/images/image_fallback.svg',
              //     fallbackImageUrl: 'assets/images/image_fallback.svg',
              //     loadingImageAsset: 'assets/images/image_fallback.svg',
              //   ),
              //   SizedBox(height: 24),
              // ],

              // Container(
              //   width: MediaQuery.of(context).size.width * 0.68,
              //   child: GridView.count(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(), // 스크롤과 충돌? 방지
              //     primary: false,
              //     // padding: const EdgeInsets.all(20),
              //     crossAxisSpacing: 8,
              //     mainAxisSpacing: 8,
              //     crossAxisCount: 2,
              //     children: <Widget>[
              //       ImageWithFallback(
              //         imageUrl: 'assets/images/image_fallback.svg',
              //         fallbackImageUrl: 'assets/images/image_fallback.svg',
              //         loadingImageAsset: 'assets/images/image_fallback.svg',
              //       ),
              //       ImageWithFallback(
              //         imageUrl: 'assets/images/image_fallback.svg',
              //         fallbackImageUrl: 'assets/images/image_fallback.svg',
              //         loadingImageAsset: 'assets/images/image_fallback.svg',
              //       ),
              //       ImageWithFallback(
              //         imageUrl: 'assets/images/image_fallback.svg',
              //         fallbackImageUrl: 'assets/images/image_fallback.svg',
              //         loadingImageAsset: 'assets/images/image_fallback.svg',
              //       ),
              //       ImageWithFallback(
              //         imageUrl: 'assets/images/image_fallback.svg',
              //         fallbackImageUrl: 'assets/images/image_fallback.svg',
              //         loadingImageAsset: 'assets/images/image_fallback.svg',
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // floatingActionButton: selectedAction == ButtonAction.removeBg
      //     ? SafeArea(
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
      //           child: CustomButton(
      //             variant: 'primary',
      //             size: 'large',
      //             text: '이미지 업로드',
      //             isFullWidth: true,
      //             onPressed: () => {},
      //           ),
      //         ),
      //       )
      //     : null,

      floatingActionButton: Align(
        alignment: Alignment.bottomCenter, // 하단 가운데로 정렬
        child: selectedAction == ButtonAction.removeBg
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  variant: 'primary',
                  size: 'large',
                  text: '이미지 업로드',
                  isFullWidth: true,
                  onPressed: () => {},
                ),
              )
            : const SizedBox.shrink(), // null 대신 빈 위젯으로 애니메이션되지 않도록
      ),

      // 구조 왜 이랬나
      // floatingActionButton: selectedAction == ButtonAction.removeBg
      //     ? Align(
      //         alignment: Alignment.bottomCenter,
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min, // Column의 크기를 필요한 만큼만 설정
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 24.0),
      //               child: CustomButton(
      //                 variant: 'primary',
      //                 size: 'large',
      //                 text: '이미지 업로드',
      //                 isFullWidth: true,
      //                 onPressed: () => {},
      //               ),
      //             ),
      //           ],
      //         ),
      //       )
      //     : null, // 조건이 false면 FAB 안 보임

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

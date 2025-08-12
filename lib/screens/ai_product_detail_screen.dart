import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/ai_product_image_edit_screen.dart';
import 'package:flutter_application_1/screens/ai_screen.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_modal_bottom_sheet.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/image_with_fallback.dart';
import 'package:flutter_application_1/widgets/typing_sequence.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart'; // 경로는 프로젝트에 맞게 조정

class AiProductDetailScreen extends StatefulWidget {
  @override
  _AIProductDetailScreenState createState() => _AIProductDetailScreenState();
}

class _AIProductDetailScreenState extends State<AiProductDetailScreen> {
  bool showSecondWidget = false;
  bool showThirdWidget = false;
  bool showFourthWidget = false;

  // const _AIScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'AI 상세페이지',
        variant: AppBarVariant.up,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomText(variant: 'h4', text: '어떤 이미지를 만들어 드릴까요?'),
              // SizedBox(height: 8),
              // CustomText(
              //   variant: 'label1',
              //   text: '상품 이미지만 올려주세요. \nAI가 자동으로 어울리는 배경을 만들어 드려요.',
              //   color: Color(0xFF5D5D5D),
              // ),
              // SizedBox(height: 24),
              // Column(
              //   spacing: 8.0,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     CustomButton(
              //       variant: 'secondary',
              //       size: 'medium',
              //       text: '이미지 배경제거',
              //       onPressed: () => {},
              //     ),
              //     CustomButton(
              //       variant: 'secondary',
              //       size: 'medium',
              //       text: 'AI 이미지 생성',
              //       onPressed: () => {},
              //     ),
              //   ],
              // ),
              SizedBox(height: 24),

              // 텍스트 영역
              SizedBox(height: 16),
              TypingSequence(
                firstWidget: TypingText(
                  variant: "h4",
                  text: '상품에 대한 내용을 알려주세요.',
                ),
                secondWidget: TypingText(
                  variant: "label1",
                  text: '상품의 구체적인 특징이나 상세한 정보를 알려주시면, 더 완성도 있게 작성할 수 있어요.',
                ),
                // TODO buttonGroupWidget
                thirdWidget: Column(
                  spacing: 8.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: ImageWithFallback(
                        imageUrl: 'assets/images/image_fallback.svg',
                        fallbackImageUrl: 'assets/images/image_fallback.svg',
                        loadingImageAsset: 'assets/images/image_fallback.svg',
                      ),
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          showDragHandle: true,
                          builder: (BuildContext context) {
                            return CustomModalBottomSheet(
                              title: '전체 레이어 변경',
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 8.0),
                                    leading: SizedBox(
                                      width: 64,
                                      height: 64,
                                      child: ImageWithFallback(
                                        imageUrl:
                                            'assets/images/image_fallback.svg',
                                        fallbackImageUrl:
                                            'assets/images/image_fallback.svg',
                                        loadingImageAsset:
                                            'assets/images/image_fallback.svg',
                                      ),
                                    ),
                                    title: Text('이미지 ${index + 1}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 8.0,
                                      children: [
                                        CustomButton(
                                          variant: 'secondary',
                                          size: 'small',
                                          text: '변경',
                                          onPressed: () {},
                                        ),
                                        CustomButton(
                                          variant: 'secondary',
                                          size: 'small',
                                          text: 'AI 생성',
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0), // 위아래 8px 마진
                                  child: Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                    height: 1,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => AiProductImageEditScreen()),
                        // );

                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) => AiProductImageEditScreen(),
                            // fullscreenDialog 단점
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: ImageWithFallback(
                        imageUrl: 'assets/images/image_fallback.svg',
                        fallbackImageUrl: 'assets/images/image_fallback.svg',
                        loadingImageAsset: 'assets/images/image_fallback.svg',
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),

              if (showThirdWidget) ...[
                Row(
                  spacing: 8,
                  children: [
                    TypingText(
                      variant: "label1",
                      text: 'AI가 이미지를 만들고 있어요. \n약간의 시간이 소요됩니다.',
                      onProgress: (progress) {
                        if (progress > 0.85 && !showFourthWidget) {
                          setState(() {
                            showFourthWidget = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter, // 하단 가운데로 정렬
        child: Column(
          mainAxisSize: MainAxisSize.min, // Column의 크기를 필요한 만큼만 설정
          children: [
            // CustomButton 위젯에 좌우 간격 추가
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0), // 좌우 여백
              child: CustomButton(
                variant: 'primary',
                size: 'large',
                text: '이미지 업로드',
                isFullWidth: true,
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

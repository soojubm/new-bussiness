import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ai_screen.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_icon_button.dart';
import 'package:flutter_application_1/widgets/custom_modal_bottom_sheet.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/image_with_fallback.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart'; // 경로는 프로젝트에 맞게 조정

class AiProductImageEditScreen extends StatefulWidget {
  @override
  _AIProductImageEditScreenState createState() =>
      _AIProductImageEditScreenState();
}

class _AIProductImageEditScreenState extends State<AiProductImageEditScreen> {
  bool showSecondWidget = false;
  bool showThirdWidget = false;
  bool showFourthWidget = false;

  // const _AIScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'AI 이미지',
        variant: AppBarVariant.up,
        colorMode: 'dark',
        actions: [
          // bottom sheet
          CustomIconButton(
            icon: SvgPicture.asset(
              '/icons/layers.svg',
              width: 24,
              height: 24,
              // colorFilter: Color(0xFFDE3B35)),
            ),
            tooltip: "아이콘 버튼 미디엄",
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                showDragHandle: true, // ✅ 드래그 핸들 표시
                builder: (BuildContext context) {
                  return CustomModalBottomSheet(
                    title: '전체 레이어 변경',
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8.0),
                          leading: SizedBox(
                            width: 64,
                            height: 64,
                            child: Image.network(
                              'https://example.com/photo.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text('Item ${index + 1}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min, // Row가 가능한 한 작게
                            spacing: 8.0,
                            children: [
                              CustomButton(
                                variant: 'secondary',
                                size: 'small',
                                text: '업로드',
                                onPressed: () => {},
                              ),
                              CustomButton(
                                variant: 'secondary',
                                size: 'small',
                                text: 'AI 생성',
                                onPressed: () => {},
                              ),
                              CustomButton(
                                variant: 'secondary',
                                size: 'small',
                                text: '텍스트 변경',
                                onPressed: () => {},
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          CustomButton(
              variant: 'secondary',
              size: 'small',
              text: "저장",
              leadingIcon: SvgPicture.asset(
                '/icons/download.svg',
                width: 20,
                height: 20,
                // colorFilter: Color(0xFFDE3B35)),
              ),
              onPressed: () => {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 뷰어
              Container(
                child: Row(
                  spacing: 8.0,
                  children: [
                    CustomIconButton(
                        icon: SvgPicture.asset(
                          '/icons/layers.svg',
                          width: 24,
                          height: 24,
                          // colorFilter: Color(0xFFDE3B35)),
                        ),
                        tooltip: "아이콘 버튼 미디엄",
                        backgroundColor: Colors.white,
                        onPressed: () {
                          print('아이콘 버튼이 눌렸습니다!');
                        }),
                    CustomIconButton(
                        icon: SvgPicture.asset(
                          '/icons/image_save.svg',
                          width: 24,
                          height: 24,
                          // colorFilter: Color(0xFFDE3B35)),
                        ),
                        tooltip: "아이콘 버튼 미디엄",
                        backgroundColor: Colors.white,
                        onPressed: () {
                          print('아이콘 버튼이 눌렸습니다!');
                        }),
                  ],
                ),
                // SizedBox(height: 24),
                // width: double.infinity,
                // height: 200,
                // child: ImageWithFallback(
                //   imageUrl:
                //       'https://example.com/photo.jpg', // 여기에 실제 이미지 URL을 넣으세요.
                //   fallbackImage: SvgPicture.asset(
                //     '/icons/image_placeholder.svg',
                //     fit: BoxFit.cover,
                //   ),
                //   fit: BoxFit.cover,
                // ),
              ),
              // 캐러셀
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

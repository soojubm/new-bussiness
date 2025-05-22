import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/template_recommended_product_detail_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_choice_chip_group.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

int _selectedIndex1 = 0;

// 메인 템플릿 화면
class TemplateScreen extends StatefulWidget {
  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final List<String> _filters = ['추천', '프로모션/이벤트', '상품소개', '부가설명', '일정/안내'];
  final Set<String> _selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    final List<int> heights =
        List.generate(20, (index) => (100 + index * 10) % 250 + 100);

    return Scaffold(
      appBar: CustomAppBar(
        variant: AppBarVariant.menu,
        title: '템플릿',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              print('알림 클릭됨');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 추천 상세페이지
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(variant: 'h5', text: '추천 상세페이지'),
                RawMaterialButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TemplateRecommendedProductDetailScreen()),
                    );
                  },
                  child: CustomText(variant: 'label2', text: '모두보기'),
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 130, // 명확한 높이 지정
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      spacing: 8.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 108,
                          height: 80,
                          margin: EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Text('패션의류/잡화 ${index + 1}')
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40),

            // 템플릿 둘러보기
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(variant: 'h5', text: '템플릿 둘러보기'),
                RawMaterialButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TemplateRecommendedProductDetailScreen()),
                    );
                  },
                  child: CustomText(variant: 'label2', text: '모두보기'),
                ),
              ],
            ),
            SizedBox(height: 12),

            // 선택된 텍스트 및 옵션들
            CustomChoiceChipGroup(
              selectedIndex: _selectedIndex1,
              chipLabels: _filters,
              chipSvgPaths: [
                '/icons/template_chip.svg',
                '/icons/template_chip.svg',
                '/icons/template_chip.svg',
                '/icons/template_chip.svg',
                '/icons/template_chip.svg',
              ],
              onSelectionChanged: (int index) {
                setState(() {
                  _selectedIndex1 = index;
                });
              },
            ),
            SizedBox(height: 20),
            // Masonry Grid
            MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: heights.length,
              shrinkWrap: true, // 콘텐츠 높이에 맞게 자동으로 줄어듦
              physics:
                  NeverScrollableScrollPhysics(), // 스크롤 충돌 방지 (부모가 스크롤하므로 내부 스크롤 막기)
              itemBuilder: (context, index) {
                return Container(
                  height: heights[index].toDouble(),
                  decoration: BoxDecoration(
                    color: Colors.teal[100 * ((index % 8) + 1)],
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text('Item $index')),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

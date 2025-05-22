import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_choice_chip_group.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

int _selectedIndex1 = 0;

class TemplateRecommendedProductDetailScreen extends StatefulWidget {
  @override
  _TemplateRecommendedProductDetailScreenState createState() =>
      _TemplateRecommendedProductDetailScreenState();
}

class _TemplateRecommendedProductDetailScreenState
    extends State<TemplateRecommendedProductDetailScreen> {
  final List<String> _filters = [
    '인기',
    '패션의류/잡화',
    '뷰티/화장품',
    '식품/다이어트',
    '라이프/디지털',
    '리빙/홈데코'
  ];
  final Set<String> _selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    final List<int> heights =
        List.generate(20, (index) => (100 + index * 10) % 250 + 100);

    return Scaffold(
      appBar: CustomAppBar(
        variant: AppBarVariant.up,
        title: '추천 상세페이지',
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
            CustomChoiceChipGroup(
              selectedIndex: _selectedIndex1,
              chipLabels: _filters,
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

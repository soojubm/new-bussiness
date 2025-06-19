import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

class FAQsScreen extends StatefulWidget {
  @override
  _FAQsScreenState createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  final List<Map<String, String>> faqs = [
    {
      'category': '요금제',
      'question': 'Free 요금제에는 어떤 기능이 있나요?',
      'answer': 'Flutter는 구글에서 만든 UI 툴킷으로, 크로스 플랫폼 앱 개발을 지원합니다.'
    },
    {
      'category': '구독',
      'question': 'Flutter는 어떤 언어로 작성되나요?',
      'answer': 'Flutter는 Dart 언어를 사용합니다.'
    },
    {
      'category': '사용 방법',
      'question': 'Flutter의 장점은 무엇인가요?',
      'answer': '빠른 개발, 높은 성능, 크로스 플랫폼 지원 등의 장점이 있습니다.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '자주 묻는 질문',
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return FAQItem(
            category: faqs[index]['category']!,
            question: faqs[index]['question']!,
            answer: faqs[index]['answer']!,
          );
        },
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String category;
  final String question;
  final String answer;

  FAQItem(
      {required this.category, required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ExpansionTile(
            // tilePadding: EdgeInsets.zero, 기본값
            tilePadding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding),
            shape: Border.all(color: Colors.transparent),
            expandedAlignment: Alignment.topLeft,
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomText(variant: 'label1', text: widget.category),
              CustomText(variant: 'h5', text: widget.question),
            ]),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    horizontalPadding, 16.0, horizontalPadding, 0),
                child: Container(
                  width: double.infinity, // 👈 너비 100% 설정
                  padding: const EdgeInsets.fromLTRB(
                      16, 16, 16, 20), // 내부 여백 (텍스트 주위)
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F3F4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomText(
                    variant: 'body',
                    text: widget.answer,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          const Divider(
            height: 1,
            color: Colors.grey,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}

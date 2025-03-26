import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

class FAQsScreen extends StatefulWidget {
  @override
  _FAQSsScreenState createState() => _FAQSsScreenState();
}

class _FAQSsScreenState extends State<FAQsScreen> {
  final List<Map<String, String>> faqs = [
    {
      'question': 'Flutter란 무엇인가요?',
      'answer': 'Flutter는 구글에서 만든 UI 툴킷으로, 크로스 플랫폼 앱 개발을 지원합니다.'
    },
    {
      'question': 'Flutter는 어떤 언어로 작성되나요?',
      'answer': 'Flutter는 Dart 언어를 사용합니다.'
    },
    {
      'question': 'Flutter의 장점은 무엇인가요?',
      'answer': '빠른 개발, 높은 성능, 크로스 플랫폼 지원 등의 장점이 있습니다.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자주 묻는 질문'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return FAQItem(
            question: faqs[index]['question']!,
            answer: faqs[index]['answer']!,
          );
        },
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        shape: Border.all(color: Colors.transparent),
        expandedAlignment: Alignment.topLeft,
        title: CustomText(
          variant: 'subhead',
          text: widget.question,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomText(variant: 'body', text: widget.answer),
          ),
        ],
      ),
    );
  }
}

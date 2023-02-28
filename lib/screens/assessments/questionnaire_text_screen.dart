import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class QuestionnaireTextScreen extends StatelessWidget {
  final List<String> text;
  const QuestionnaireTextScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: Center(
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              shrinkWrap: true,
              itemCount: text.length,
              itemBuilder: ((context, index) {
                return Center(child: MarkdownBody(data: text[index]));
              })),
        ));
  }
}

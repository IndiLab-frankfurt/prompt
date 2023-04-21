import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class QuestionnaireTextScreen extends StatelessWidget {
  final List<String> text;
  const QuestionnaireTextScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor.withOpacity(0.7),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Center(
            child: ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                shrinkWrap: true,
                itemCount: text.length,
                itemBuilder: ((context, index) {
                  return Center(child: MarkdownBody(data: text[index]));
                })),
          )),
    );
  }
}

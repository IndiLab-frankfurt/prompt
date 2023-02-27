import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SpeechBubble extends StatelessWidget {
  final String text;
  SpeechBubble({this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MarkdownBody(
        data: "### " + text,
      ),
      margin: EdgeInsets.all(5),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 2,
              offset: Offset(5.0, 2.0),
              color: Colors.black.withOpacity(.12))
        ],
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    );
  }
}

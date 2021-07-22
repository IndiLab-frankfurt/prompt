import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SpeechBubble extends StatelessWidget {
  final String text;
  SpeechBubble({this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MarkdownBody(
        data: "## " + text,
      ),
      // child: Text(
      //   this.text,
      //   style: Theme.of(context).textTheme.headline6,
      // ),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: .5,
              spreadRadius: 1.0,
              color: Colors.black.withOpacity(.12))
        ],
        color: Theme.of(context).selectedRowColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    );
  }
}

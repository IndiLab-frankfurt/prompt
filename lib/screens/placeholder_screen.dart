import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PlaceholderScreen extends StatelessWidget {
  final String text;
  const PlaceholderScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: MarkdownBody(data: "### " + text)),
    );
  }
}

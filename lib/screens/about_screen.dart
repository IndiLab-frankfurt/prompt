import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [MarkdownBody(data: "# Über Prompt")],
    );
  }
}

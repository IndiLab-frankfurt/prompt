import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class InstructionsAppPermissions extends StatelessWidget {
  const InstructionsAppPermissions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(data: "### Instruktionen für die App-Berechtigungen")
      ],
    ));
  }
}

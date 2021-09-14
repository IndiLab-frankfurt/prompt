import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CabuuCodeScreen extends StatelessWidget {
  const CabuuCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MarkdownBody(data: "# Dein Cabuu Code"),
          Center(
            child: MarkdownBody(data: "# 12356"),
          ),
          MarkdownBody(
              data:
                  "Schreibe dir diesen Code auf, du musst ihn dann in cabuu eingeben")
        ],
      ),
    );
  }
}

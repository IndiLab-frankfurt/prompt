import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class CabuuCodeScreen extends StatelessWidget {
  const CabuuCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = new DateFormat("dd.MM.yyyy");
    var targetDate = format.format(DateTime.now().add(Duration(days: 9)));

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Dein Cabuu Code lautet:",
              style: Theme.of(context).textTheme.subtitle1),
          Center(
            child: MarkdownBody(data: "# **12356**"),
          ),
          MarkdownBody(
              data:
                  "### Schreibe dir diesen Code auf, du musst ihn dann in cabuu eingeben."),
          MarkdownBody(data: "### Schreibe dir außerdem dieses Datum auf:"),
          Center(
            child: MarkdownBody(data: "# **$targetDate**"),
          ),
        ],
      ),
    );
  }
}

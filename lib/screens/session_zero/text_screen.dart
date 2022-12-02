import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';

class TextScreen extends StatelessWidget {
  final List<String> paragraphs;
  const TextScreen({
    Key? key,
    required this.paragraphs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var text in paragraphs) {
      children.add(Text(text, style: Theme.of(context).textTheme.subtitle1));
      children.add(UIHelper.verticalSpaceMedium());
    }

    return Container(child: ListView(children: children));
  }
}

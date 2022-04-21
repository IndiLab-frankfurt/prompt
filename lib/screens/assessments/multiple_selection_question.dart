import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

typedef void MultipleSelectionQuestionCallback(
    String itemId, bool? selectedValue);

class MultipleSelectionQuestion extends StatefulWidget {
  final String title;
  final Map<String, String> labels;
  final String id;
  final MultipleSelectionQuestionCallback callback;
  final bool randomize;
  final List<String>? selectedValues;

  const MultipleSelectionQuestion(
      {Key? key,
      this.title = "",
      this.selectedValues,
      required this.labels,
      required this.id,
      required this.callback,
      this.randomize = false})
      : super(key: key);

  @override
  State<MultipleSelectionQuestion> createState() =>
      _MultipleSelectionQuestionState();
}

class _MultipleSelectionQuestionState extends State<MultipleSelectionQuestion> {
  List<String> _selectedValues = [];

  MultipleSelectionQuestionnaireState() {
    if (widget.selectedValues != null) {
      _selectedValues = widget.selectedValues!;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    for (var key in widget.labels.keys) {
      items.add(buildCheckboxItem(key, widget.labels[key]!));
    }

    return Column(children: <Widget>[
      MarkdownBody(
        data: "## " + widget.title,
      ),
      Column(mainAxisAlignment: MainAxisAlignment.start, children: items)
    ]);
  }

  buildCheckboxItem(String key, String text) {
    var selected = _selectedValues.contains(key);
    return CheckboxListTile(
      title: MarkdownBody(data: "### " + text),
      value: selected,
      onChanged: (bool? newValue) {
        if (newValue != null) {
          if (newValue) {
            setState(() {
              _selectedValues.add(key);
            });
          } else {
            setState(() {
              _selectedValues.remove(key);
            });
          }
        }
        widget.callback("${this.widget.id}_$key", newValue);
        setState(() {});
      },
    );
  }

  String? getLabel(String key) {
    if (widget.labels.containsKey(key)) {
      return widget.labels[key];
    }
    return "MISSING LABEL";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

typedef void ChoiceQuestionCallback(String val);

class SingleChoiceQuestion extends StatefulWidget {
  @override
  _SingleChoiceQuestionState createState() => _SingleChoiceQuestionState();

  final String title;
  final String id;
  final int groupValue;
  final bool randomize;
  final Map<String, String> labels;
  final ChoiceQuestionCallback onSelection;

  SingleChoiceQuestion(
      {Key? key,
      this.title = "",
      required this.labels,
      this.groupValue = -1,
      this.id = "",
      this.randomize = false,
      required this.onSelection})
      : super(key: key);
}

class _SingleChoiceQuestionState extends State<SingleChoiceQuestion> {
  int _groupValue = -1;
  Map<String, String> items = {};

  randomizeMap(Map<String, String> map) {
    Map<String, String> newmap = {};
    var list = List<int>.generate(map.length, (i) => i + 1);
    list.shuffle();
    for (var i in list) {
      var existingKey = widget.labels.keys.elementAt(i);
      var existingValue = widget.labels.values.elementAt(i);
      newmap[existingKey] = existingValue;
    }

    return newmap;
  }

  @override
  void initState() {
    super.initState();
    _groupValue = widget.groupValue;

    if (widget.randomize) {
      items = randomizeMap(widget.labels);
    } else {
      items = widget.labels;
    }
  }

  _onChanged(int groupValue, String selectedValue) {
    setState(() {
      _groupValue = groupValue;
    });

    widget.onSelection(selectedValue);
  }

  buildStaticItem(int groupValue, String text) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Radio(
            groupValue: _groupValue,
            value: groupValue,
            onChanged: (value) {
              if (value is int) {
                _onChanged(value, groupValue.toString());
              }
            },
          ),
          Expanded(
            child: MarkdownBody(
              data: text,
            ),
          )
        ],
      ),
      onTap: () {
        _onChanged(groupValue, groupValue.toString());
      },
    );
  }

  buildSingleTextInputItemWithSelector(int groupValue, String text,
      {String hintText = ""}) {
    text = groupValue.toString();
    return Column(
      children: [
        InkWell(
          child: Row(
            children: <Widget>[
              Radio(
                groupValue: _groupValue,
                value: groupValue,
                onChanged: (val) {
                  if (val is int) {
                    _onChanged(val, text);
                  }
                },
              ),
              MarkdownBody(
                data: text,
              )
            ],
          ),
          onTap: () {
            FocusScope.of(context).nextFocus();
            _onChanged(groupValue, text);
          },
        ),
        Container(
          margin: EdgeInsets.only(left: 15.0),
          child: TextField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            onTap: () {
              setState(() {
                _groupValue = groupValue;
              });
            },
            onChanged: (text) {
              _onChanged(groupValue, text);
            },
          ),
        )
      ],
    );
  }

  buildTextInputItem(int groupValue, String text, {String hintText = ""}) {
    text = groupValue.toString();
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text(hintText)),
            onTap: () {
              setState(() {
                _groupValue = groupValue;
              });
            },
            onChanged: (text) {
              _onChanged(groupValue, text);
            },
          ),
        )
      ],
    );
  }

  String? getLabel(String key) {
    if (widget.labels.containsKey(key)) {
      return widget.labels[key];
    }
    return "MISSING LABEL";
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    int displayGroupValue = 1;
    for (var key in widget.labels.keys) {
      if (key.contains("TEXTINPUT")) {
        if (widget.labels.length == 1) {
          items.add(buildTextInputItem(displayGroupValue, widget.labels[key]!,
              hintText: widget.labels[key]!));
        } else {
          items.add(buildSingleTextInputItemWithSelector(
              displayGroupValue, widget.labels[key]!));
          _groupValue = displayGroupValue;
        }
      } else {
        items.add(buildStaticItem(displayGroupValue, widget.labels[key]!));
      }
      displayGroupValue += 1;
    }

    return Column(children: <Widget>[
      MarkdownBody(
        data: "## " + widget.title,
      ),
      Column(mainAxisAlignment: MainAxisAlignment.start, children: items)
    ]);
  }
}

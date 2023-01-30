import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/models/question.dart';

typedef void ChoiceQuestionCallback(String val);

class SingleChoiceQuestion extends StatefulWidget {
  @override
  _SingleChoiceQuestionState createState() => _SingleChoiceQuestionState();

  final ChoiceQuestion question;
  final int selectecValue;
  final bool randomize;
  final ChoiceQuestionCallback onSelection;

  SingleChoiceQuestion(
      {Key? key,
      required this.question,
      this.selectecValue = -1,
      this.randomize = false,
      required this.onSelection})
      : super(key: key);
}

class _SingleChoiceQuestionState extends State<SingleChoiceQuestion> {
  int _selectedValue = -1;
  Map<String, String> items = {};

  randomizeMap(Map<String, String> map) {
    Map<String, String> newmap = {};
    var list = List<int>.generate(map.length, (i) => i + 1);
    list.shuffle();
    for (var i in list) {
      var existingKey = widget.question.choices.keys.elementAt(i);
      var existingValue = widget.question.choices.values.elementAt(i);
      newmap[existingKey] = existingValue;
    }

    return newmap;
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectecValue;

    if (widget.randomize) {
      items = randomizeMap(widget.question.choices);
    } else {
      items = widget.question.choices;
    }
  }

  _onChanged(int groupValue, String selectedValue) {
    setState(() {
      _selectedValue = groupValue;
    });
    widget.question.selectedChoices = [selectedValue];
    widget.onSelection(selectedValue);
  }

  buildStaticItem(int groupValue, String text) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Radio(
            groupValue: _selectedValue,
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
                groupValue: _selectedValue,
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
                _selectedValue = groupValue;
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
                _selectedValue = groupValue;
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
    if (widget.question.choices.containsKey(key)) {
      return widget.question.choices[key];
    }
    return "MISSING LABEL";
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    int displayGroupValue = 1;
    for (var key in widget.question.choices.keys) {
      if (key.contains("TEXTINPUT")) {
        if (widget.question.choices.length == 1) {
          items.add(buildTextInputItem(
              displayGroupValue, widget.question.choices[key]!,
              hintText: widget.question.choices[key]!));
        } else {
          items.add(buildSingleTextInputItemWithSelector(
              displayGroupValue, widget.question.choices[key]!));
          _selectedValue = displayGroupValue;
        }
      } else {
        items.add(
            buildStaticItem(displayGroupValue, widget.question.choices[key]!));
      }
      displayGroupValue += 1;
    }

    return Column(children: <Widget>[
      MarkdownBody(
        data: "## " + widget.question.questionText,
      ),
      Column(mainAxisAlignment: MainAxisAlignment.start, children: items)
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/choice_question_view_model.dart';

typedef void ChoiceQuestionCallback(String val);

class SingleChoiceQuestionView extends StatefulWidget {
  @override
  _SingleChoiceQuestionViewState createState() =>
      _SingleChoiceQuestionViewState();

  final ChoiceQuestionViewModel question;
  final int selectecValue;
  final ChoiceQuestionCallback onSelection;

  SingleChoiceQuestionView(
      {Key? key,
      required this.question,
      this.selectecValue = -1,
      required this.onSelection})
      : super(key: key);
}

class _SingleChoiceQuestionViewState extends State<SingleChoiceQuestionView> {
  int _selectedValue = -1;
  Map<String, String> items = {};

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectecValue;
    items = widget.question.choices;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _onChanged(int groupValue, String selectedValue) {
    setState(() {
      _selectedValue = groupValue;
    });
    widget.question.onSingleChoiceSelection(selectedValue);
    // map the groupValue to the index of the choice in the list of choices
    if (groupValue >= 0 && groupValue <= widget.question.choices.length) {
      var choice = widget.question.choices.keys.toList()[groupValue - 1];
      widget.question.selectedChoices = [choice];
      widget.onSelection(choice);
    }
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

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor.withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: ListView(
        children: <Widget>[
          MarkdownBody(
            data: "**${widget.question.questionText}**",
          ),
          UIHelper.verticalSpaceMedium,
          ...items,
        ],
      ),
    );
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
            child: Text(text, style: TextStyle(fontSize: 15.0)),
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
              Text(text, style: TextStyle(fontSize: 15.0))
            ],
          ),
          onTap: () {
            FocusScope.of(context).nextFocus();
            _onChanged(groupValue, text);
          },
        ),
        Container(
          color: Colors.grey[200],
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
          color: Colors.grey[200],
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
}

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/choice_question_view_model.dart';
import 'package:prompt/widgets/question_container.dart';

typedef void MultipleChoiceQuestionCallback(List<String> selectedValues);

class MultipleChoiceQuestionView extends StatefulWidget {
  @override
  _MultipleChoiceQuestionViewState createState() =>
      _MultipleChoiceQuestionViewState();

  final ChoiceQuestionViewModel question;
  final List<String> selectedValues;
  final MultipleChoiceQuestionCallback onSelection;

  MultipleChoiceQuestionView(
      {Key? key,
      required this.question,
      required this.selectedValues,
      required this.onSelection})
      : super(key: key);
}

class _MultipleChoiceQuestionViewState
    extends State<MultipleChoiceQuestionView> {
  List<String> _selectedValues = [];
  Map<String, String> items = {};

  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.selectedValues);
    items = widget.question.choices;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _onChanged(bool value, String selectedValue) {
    setState(() {
      if (value) {
        _selectedValues.add(selectedValue);
      } else {
        _selectedValues.remove(selectedValue);
      }
    });
    widget.question.onMultipleChoiceSelection(selectedValue);
    widget.onSelection(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    int displayGroupValue = 1;
    for (var key in widget.question.choices.keys) {
      if (key.contains("TEXTINPUT")) {
        items.add(buildTextInputItem(
            displayGroupValue, widget.question.choices[key]!,
            hintText: widget.question.choices[key]!));
      } else {
        items.add(
            buildStaticItem(displayGroupValue, widget.question.choices[key]!));
      }
      displayGroupValue += 1;
    }

    return QuestionContainer(
      data: widget.question.questionText,
      choices: [...items],
      instructions: widget.question.instructions,
    );
  }

  buildStaticItem(int groupValue, String text) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: _selectedValues.contains(text),
            onChanged: (value) {
              if (value is bool) {
                _onChanged(value, text);
              }
            },
          ),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 15.0)),
          )
        ],
      ),
      onTap: () {
        setState(() {
          if (_selectedValues.contains(text)) {
            _selectedValues.remove(text);
          } else {
            _selectedValues.add(text);
          }
        });
        widget.question.onMultipleChoiceSelection(text);
        widget.onSelection(_selectedValues);
      },
    );
  }

  buildTextInputItem(int groupValue, String text, {String hintText = ""}) {
    var groupValueString = groupValue.toString();
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: hintText,
              ),
              onTap: () {
                setState(() {
                  _selectedValues.add(groupValueString);
                });
              },
              onChanged: (text) {
                _onChanged(_selectedValues.contains(groupValueString), text);
              },
            ),
            value: _selectedValues.contains(groupValueString),
            onChanged: (val) {
              setState(() {
                if (val == true) {
                  _selectedValues.add(groupValueString);
                } else {
                  _selectedValues.remove(groupValueString);
                }
              });
              List<String> selectedChoices = [];
              _selectedValues.forEach((gv) {
                selectedChoices
                    .add(widget.question.choices.keys.toList()[groupValue - 1]);
              });
              widget.question.selectedChoices = selectedChoices;
              widget.onSelection(selectedChoices);
            },
          ),
        )
      ],
    );
  }
}

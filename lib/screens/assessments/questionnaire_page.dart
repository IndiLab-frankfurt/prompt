import 'package:flutter/material.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/models/question.dart';
import 'package:prompt/screens/assessments/multiple_selection_question.dart';
import 'package:prompt/screens/assessments/single_selection_question.dart';
import 'package:prompt/screens/assessments/questionnaire_text_input.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/ui_helper.dart';

typedef void ItemSelectedCallback(
    String assessment, String itemId, String value);

typedef void OnAssessmentCompletedCallback(Questionnaire assessment);

typedef void OnLoadedCallback(Questionnaire assessment);

class QuestionnairePage extends StatefulWidget {
  final Questionnaire assessment;
  final ItemSelectedCallback onItemSelected;
  final OnLoadedCallback onLoaded;
  final OnAssessmentCompletedCallback? onAssessmentCompleted;
  const QuestionnairePage(this.assessment, this.onItemSelected,
      {required this.onLoaded, this.onAssessmentCompleted, Key? key})
      : super(key: key);

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  Map<String, List<String>> _results = {};

  @override
  void initState() {
    super.initState();

    for (var item in widget.assessment.items) {
      _results[item.id] = [];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.onLoaded(widget.assessment);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => afterBuild());
    print(widget.assessment.title);
    return Scrollbar(
      thickness: 8.0,
      // isAlwaysShown: true,
      child: ListView(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        shrinkWrap: true,
        children: <Widget>[
          Visibility(
            visible: widget.assessment.title.isNotEmpty,
            child: Card(
                child: Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.assessment.title,
                    textAlign: TextAlign.center,
                    style: (TextStyle(fontSize: 18)),
                  )),
            )),
          ),
          for (var index = 0; index < widget.assessment.items.length; index++)
            buildQuestionCard(widget.assessment.items[index], index),
          UIHelper.verticalSpaceMedium(),
          Visibility(
            visible: !_isFilledOut(),
            child: Text(
                "Du hast noch nicht alle Fragen beantwortet. Sobald du für alle Fragen eine Auswahl getroffen hast, kannst du weiter zum nächsten Schritt"),
          )
        ],
      ),
    );
  }

  void afterBuild() {
    if (_isFilledOut()) {
      if (this.widget.onAssessmentCompleted != null) {
        this.widget.onAssessmentCompleted!(this.widget.assessment);
      }
    }
  }

  buildQuestionCard(Question assessmentItem, int index) {
    Widget questionWidget = Text("Something went wrong, check your code!");

    if (assessmentItem.type == QuestionType.single) {
      questionWidget = buildSingleSelectionQuestion(assessmentItem, index);
    }
    if (assessmentItem.type == QuestionType.multiple) {
      questionWidget = buildMultipleSelectionQuestion(assessmentItem, index);
    }
    if (assessmentItem.type == QuestionType.text_numeric) {
      questionWidget = buildTextInput(assessmentItem, index);
    }
    if (assessmentItem.type == QuestionType.text) {
      questionWidget = buildTextInput(assessmentItem, index);
    }

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: questionWidget,
        ));
  }

  Widget buildMultipleSelectionQuestion(Question question, int index) {
    return MultipleSelectionQuestion(
      id: question.id,
      labels: question.labels,
      callback: (itemId, selectedValue) {
        setState(() {
          widget.onItemSelected(
              widget.assessment.title, itemId, selectedValue.toString());
          if (selectedValue != null) {
            if (selectedValue) {
              _results[question.id]!.add(selectedValue.toString());
            } else {
              _results[question.id]!.remove(selectedValue.toString());
            }
          } else {
            _results[question.id]!.remove(selectedValue.toString());
          }
        });
      },
      selectedValues: _results[question.id]!,
    );
  }

  Widget buildSingleSelectionQuestion(Question question, int index) {
    var groupValue = -1;
    if (_results[question.id]!.length > 0) {
      if (_results.containsKey(widget.assessment.items[index].id)) {
        var parseResult =
            int.tryParse(_results[widget.assessment.items[index].id]![0]);
        if (parseResult is int) {
          groupValue = parseResult;
        }
      }
    }
    // if (_results.containsKey(widget.assessment.items[index].id)) {
    //   var parseResult =
    //       int.tryParse(_results[widget.assessment.items[index].id]![0]);
    //   if (parseResult is int) {
    //     groupValue = parseResult;
    //   }
    // }

    return SingleSelectionQuestion(
      title: question.questionText,
      labels: question.labels,
      id: question.id,
      groupValue: groupValue,
      callback: (val) {
        print("Changed Assessment value to: $val");
        setState(() {
          this.widget.onItemSelected(
              widget.assessment.id, widget.assessment.items[index].id, val);
          _results[widget.assessment.items[index].id]!.add(val);
        });
      },
    );
  }

  Widget buildTextInput(Question item, int index) {
    TextInputType inputType = TextInputType.text;
    if (item.type == QuestionType.text_numeric) {
      inputType = TextInputType.number;
    }
    return QuestionnaireTextInput(
      question: item.questionText,
      textInputType: inputType,
      callback: (val) {
        print("Text question $index changed to: $val");
        setState(() {
          this.widget.onItemSelected(
              widget.assessment.id, widget.assessment.items[index].id, val);
          _results[widget.assessment.items[index].id] = [val];
        });
      },
    );
  }

  bool _isFilledOut() {
    bool canSubmit = true;
    for (var assessmentItem in widget.assessment.items) {
      if (_results[assessmentItem.id]!.length == 0) canSubmit = false;
    }

    return canSubmit;
  }
}

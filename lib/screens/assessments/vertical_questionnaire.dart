import 'package:flutter/material.dart';
import 'package:prompt/models/question.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/screens/assessments/single_choice_question.dart';
import 'package:prompt/shared/ui_helper.dart';

typedef void ItemSelectedCallback(
    String assessment, String itemId, String value);

typedef void OnAssessmentCompletedCallback(Questionnaire questionnaire);

typedef void OnLoadedCallback(Questionnaire questionnaire);

class VerticalQuestionnaire extends StatefulWidget {
  final Questionnaire questionnaire;
  final ItemSelectedCallback onFinished;
  final OnLoadedCallback onLoaded;
  final OnAssessmentCompletedCallback? onAssessmentCompleted;
  const VerticalQuestionnaire(this.questionnaire, this.onFinished,
      {required this.onLoaded, this.onAssessmentCompleted, Key? key})
      : super(key: key);

  @override
  _VerticalQuestionnaireState createState() => _VerticalQuestionnaireState();
}

class _VerticalQuestionnaireState extends State<VerticalQuestionnaire> {
  Map<String, String> _results = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.onLoaded(widget.questionnaire);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());
    print(widget.questionnaire.title);
    return Scrollbar(
      thickness: 8.0,
      child: ListView(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        shrinkWrap: true,
        children: <Widget>[
          Visibility(
            visible: widget.questionnaire.title.isNotEmpty,
            child: Card(
                child: Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.questionnaire.title,
                    textAlign: TextAlign.center,
                    style: (TextStyle(fontSize: 18)),
                  )),
            )),
          ),
          for (var index = 0;
              index < widget.questionnaire.questions.length;
              index++)
            buildQuestionCard(widget.questionnaire.questions[index], index),
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
        this.widget.onAssessmentCompleted!(this.widget.questionnaire);
      }
    }
  }

  buildQuestionCard(Question question, int index) {
    var groupValue = -1;
    if (_results.containsKey(widget.questionnaire.questions[index].name)) {
      var parseResult =
          int.tryParse(_results[widget.questionnaire.questions[index].name]!);
      if (parseResult is int) {
        groupValue = parseResult;
      }
    }

    if (question is SingleChoiceQuestion) {
      // cast question  to SingleChoiceQuestion
      var singleChoiceQuestion = question as ChoiceQuestion;
      return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChoiceQuestion(
              question: singleChoiceQuestion,
              selectecValue: groupValue,
              onSelection: (val) {
                print("Changed Assessment value to: $val");
                setState(() {
                  this.widget.onFinished(widget.questionnaire.name,
                      widget.questionnaire.questions[index].name, val);
                  _results[widget.questionnaire.questions[index].name] = val;
                });
              },
            ),
          ));
    }
  }

  bool _isFilledOut() {
    bool canSubmit = true;
    for (var assessmentItem in widget.questionnaire.questions) {
      if (!_results.containsKey(assessmentItem.name)) canSubmit = false;
    }

    return canSubmit;
  }
}

import 'package:flutter/material.dart';
import 'package:prompt/models/question.dart';
import 'package:prompt/screens/assessments/multi_page_screen.dart';
import 'package:prompt/screens/assessments/questionnaire_text_screen.dart';
import 'package:prompt/screens/assessments/single_choice_question.dart';
import 'package:prompt/viewmodels/onboarding_questionnaire_view_model.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class HorizontalQuestionnaire extends StatefulWidget {
  const HorizontalQuestionnaire({Key? key}) : super(key: key);

  @override
  State<HorizontalQuestionnaire> createState() =>
      _HorizontalQuestionnaireState();
}

class _HorizontalQuestionnaireState extends State<HorizontalQuestionnaire> {
  List<Widget> _screens = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late OnboardingQuestionnaireViewModel vm =
      Provider.of<OnboardingQuestionnaireViewModel>(context);

  init() async {
    return this._memoizer.runOnce(() async {
      _screens = [];

      for (var question in vm.questionnaire.questions) {
        if (question is ChoiceQuestion) {
          _screens.add(Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(3, 3),
                  ),
                ],
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChoiceQuestion(
                  question: question, onSelection: (_) {})));
        }
        if (question is QuestionnaireText) {
          _screens.add(Column(children: [
            QuestionnaireTextScreen(
                text: question.text, key: ValueKey(question.name)),
          ]));
        }
      }

      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          child: FutureBuilder(
            future: init(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return MultiPageScreen(
                  vm,
                  _screens,
                  showBottomBar: false,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}

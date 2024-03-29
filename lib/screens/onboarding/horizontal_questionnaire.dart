import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_page_screen.dart';
import 'package:prompt/screens/assessments/questionnaire_text_screen.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';
import 'package:prompt/widgets/single_choice_question_view.dart';
import 'package:prompt/viewmodels/choice_question_view_model.dart';
import 'package:prompt/viewmodels/questionnaire_textpage_view_model.dart';
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

  late MultiPageQuestionnaireViewModel vm =
      Provider.of<MultiPageQuestionnaireViewModel>(context);

  init() async {
    return this._memoizer.runOnce(() async {
      _screens = [];

      for (var question in vm.questionnaire.questions) {
        if (question is ChoiceQuestionViewModel) {
          _screens.add(SingleChoiceQuestionView(
              question: question, onSelection: (_) {}));
        }
        if (question is QuestionnaireTextPageViewModel) {
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

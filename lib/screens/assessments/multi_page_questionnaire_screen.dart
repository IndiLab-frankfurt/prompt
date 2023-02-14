import 'package:flutter/material.dart';
import 'package:prompt/models/question.dart';
import 'package:prompt/screens/assessments/multi_page_screen.dart';
import 'package:prompt/screens/assessments/single_choice_question.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class MultiPageQuestionnaire extends StatefulWidget {
  const MultiPageQuestionnaire({Key? key}) : super(key: key);

  @override
  State<MultiPageQuestionnaire> createState() => _MultiPageQuestionnaireState();
}

class _MultiPageQuestionnaireState extends State<MultiPageQuestionnaire> {
  List<Widget> _screens = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late MultiPageQuestionnaireViewModel vm =
      Provider.of<MultiPageQuestionnaireViewModel>(context);
  init() async {
    return this._memoizer.runOnce(() async {
      _screens = [];

      for (var question in vm.questionnaire.questions) {
        if (question is ChoiceQuestion) {
          _screens.add(Column(
              mainAxisAlignment: MainAxisAlignment.center,
              key: ValueKey(question.name),
              children: [
                SingleChoiceQuestion(question: question, onSelection: (_) {}),
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
          decoration: UIHelper.defaultBoxDecoration,
          child: Scaffold(
              appBar: PromptAppBar(showBackButton: true),
              drawer: PromptDrawer(),
              extendBodyBehindAppBar: true,
              body: FutureBuilder(
                future: init(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        decoration: UIHelper.defaultBoxDecoration,
                        padding: UIHelper.containerPadding,
                        child: MultiPageScreen(
                          vm,
                          _screens,
                        ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
        ));
  }
}

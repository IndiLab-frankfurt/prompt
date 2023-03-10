import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_page_screen.dart';
import 'package:prompt/screens/assessments/questionnaire_text_screen.dart';
import 'package:prompt/widgets/single_choice_question_view.dart';
import 'package:prompt/viewmodels/choice_question_view_model.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';
import 'package:prompt/viewmodels/questionnaire_textpage_view_model.dart';
import 'package:prompt/widgets/background_image_container.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class MultiPageQuestionnaire extends StatefulWidget {
  MultiPageQuestionnaire({Key? key}) : super(key: key);

  @override
  State<MultiPageQuestionnaire> createState() => _MultiPageQuestionnaireState();
}

class _MultiPageQuestionnaireState extends State<MultiPageQuestionnaire> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late MultiPageQuestionnaireViewModel vm =
      Provider.of<MultiPageQuestionnaireViewModel>(context);

  init() async {
    return this._memoizer.runOnce(() async {
      List<Widget> _screens = [];

      for (var question in vm.pages) {
        if (question is ChoiceQuestionViewModel) {
          _screens.add(Column(
              mainAxisAlignment: MainAxisAlignment.center,
              key: ValueKey(question.name),
              children: [
                SingleChoiceQuestionView(
                    question: question, onSelection: (_) {}),
              ]));
        }

        if (question is QuestionnaireTextPageViewModel) {
          _screens.add(Column(children: [
            QuestionnaireTextScreen(
                text: question.text, key: ValueKey(question.name)),
          ]));
        }
      }

      return _screens;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
            child: Scaffold(
                appBar: PromptAppBar(showBackButton: true),
                drawer: PromptDrawer(),
                extendBodyBehindAppBar: true,
                body: FutureBuilder(
                  future: init(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return BackgroundImageContainer(
                          child: MultiPageScreen(
                        vm,
                        snapshot.data,
                      ));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ))));
  }
}

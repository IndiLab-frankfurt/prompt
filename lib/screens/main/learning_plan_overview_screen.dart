import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';

class LearningPlanOverviewScreen extends StatelessWidget {
  const LearningPlanOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var studyService = locator<StudyService>();
    var nextVocabDate = studyService.getNextVocabTestDate();
    var deadlineDate =
        studyService.getNextVocabTestDate().subtract(Duration(days: 1));
    // format date to locale string
    var format = new DateFormat.yMMMMd('de_DE');

    var items = [
      Text(
        "Bis wann habe ich Zeit, die nächste Vokabelliste zu lernen?",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      UIHelper.verticalSpaceMedium,
      Text(
        format.format(deadlineDate),
      ),
      UIHelper.verticalSpaceMedium,
      Text(
        "Wann soll ich den nächsten Test machen?",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      Text(
        format.format(nextVocabDate),
      ),
    ];
    return Scaffold(
        appBar: PromptAppBar(
          showBackButton: true,
        ),
        drawer: PromptDrawer(),
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Container(
                    child: Center(child: items[index]),
                  ));
            }),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
    var imgExplain1 = "assets/tutorial/cabuu_Erklaerung_Prompt_App1.png";
    var imgExplain2 = "assets/tutorial/cabuu_Erklaerung_Prompt_App2.png";
    var imgExplain3 = "assets/tutorial/cabuu_Erklaerung_Prompt_App3.png";
    var imgExplain4 = "assets/tutorial/cabuu_Erklaerung_Prompt_App4.png";

    var items = [
      Text("Hier findest du alle wichtigen Informationen zu cabuu",
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center),
      UIHelper.verticalSpaceSmall,
      Text(
        "Bis wann habe ich Zeit, die nächste Vokabelliste zu lernen?",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[300]),
        textAlign: TextAlign.center,
      ),
      Text(
        format.format(deadlineDate),
      ),
      Text(
        "Wann soll ich den nächsten Test machen?",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[300]),
        textAlign: TextAlign.center,
      ),
      Text(
        format.format(nextVocabDate),
      ),
      Text(
        "Wie aktiviere ich einen Lernplan in cabuu?",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[300]),
        textAlign: TextAlign.center,
      ),
      Text(
        'Klicke auf die Liste und wähle "Lernplan erstellen". Gib als Enddatum das oben angegebene Datum ein.',
        textAlign: TextAlign.center,
      ),
      Image(
        image: AssetImage(imgExplain1),
      ),
      Image(
        image: AssetImage(imgExplain2),
      ),
      Text(
        "Wie mache ich den Test in cabuu?",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[300]),
        textAlign: TextAlign.center,
      ),
      Text(
        'Klicke auf die Liste und wähle "Lass dich abfragen".',
        textAlign: TextAlign.center,
      ),
      Image(
        image: AssetImage(imgExplain3),
      ),
      Text(
        'oder klicke auf dem Hauptbildschirm auf "Lass dich abfragen".',
        textAlign: TextAlign.center,
      ),
      Image(
        image: AssetImage(imgExplain4),
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
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: Center(child: items[index]),
              );
            }),
          ),
        ));
  }
}

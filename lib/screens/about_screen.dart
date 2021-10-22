import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.file,
    //     'assets/videos/cabuu_test_lernplan.mp4');
    // _betterPlayerController = BetterPlayerController(
    //     BetterPlayerConfiguration(),
    //     betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PromptAppBar(
          showBackButton: true,
        ),
        drawer: PromptDrawer(),
        body: Container(
            margin: UIHelper.containerMargin,
            child: ListView(children: [
              FullWidthButton(
                  text: "Drücke hier, um das Einführungsvideo anzusehen.",
                  onPressed: () async {
                    await Navigator.pushNamed(
                        context, RouteNames.ABOUT_PROMPT_VIDEO);
                  }),
              UIHelper.verticalSpaceMedium(),
              MarkdownBody(data: "# Was ist PROMPT?"),
              MarkdownBody(
                  data:
                      "PROMPT ist eine Studie des DIPF | Leibniz-Institut für Bildungsforschung und Bildungsinformation. Mit deiner Hilfe wollen wir herausfinden, wie wir Kinder am besten beim Lernen mit Apps - wie zum Beispiel cabuu - unterstützen können. "),
              UIHelper.verticalSpaceMedium(),
              MarkdownBody(data: "# Wie läuft PROMPT ab?"),
              MarkdownBody(
                  data: "Während der Studie sollst du 2 Apps benutzen: "),
              MarkdownBody(
                  data:
                      "Mit der App “cabuu” lernst du bis zu den Weihnachtsferien hintereinander insgesamt 6 Vokabellisten. Du hast für jede Liste 8 Tage Zeit. Am neunten Tag machst du in cabuu einen Test, um zu sehen, wie gut du die Vokabeln kannst. Deshalb stellen wir dir während der Studie einige Fragen dazu, wie du mit cabuu lernst. Außerdem stellen wir dir Aufgaben. Dabei ist es wichtig, dass du "),
              MarkdownBody(data: "* jeden Tag PROMPT benutzt, "),
              MarkdownBody(
                  data: "* pünktlich die kurzen Vokabeltests machst, "),
              MarkdownBody(
                  data: "* pünktlich deine neue Lernliste aktivierst und  "),
              MarkdownBody(
                  data:
                      "* dich bei den Aufgaben richtig anstrengst und alle Fragen ehrlich beantwortest. "),
              MarkdownBody(data: "Die App erinnert dich an deine Aufgaben"),
              MarkdownBody(
                  data:
                      "Obwohl wir dich dazu ermuntern wollen, jeden Tag ein paar Vokabeln in cabuu zu lernen, schaffst du das vielleicht nicht immer. Das ist nicht schlimm. Ganz wichtig ist aber, dass du daran denkst, die App PROMPT jeden Tag zu benutzen - und zwar möglichst noch morgens vor der Schule und auch am Wochenende. An Tagen, an denen du mit cabuu lernst, benutzt du PROMPT danach noch einmal, um uns zu erzählen, wie das Lernen mit cabuu gelaufen ist. An Tagen, an denen du nicht mit cabuu lernst, benutzt du PROMPT erst wieder am nächsten Morgen. Wie viele Tage du schon gemacht hast und wie viele noch fehlen, kannst du in deiner Fortschrittsanzeige sehen. "),
              UIHelper.verticalSpaceMedium(),
              MarkdownBody(data: "# Was bekomme ich dafür?"),
              MarkdownBody(
                  data:
                      "Immer, wenn du die App PROMPT benutzt, bekommst du dafür 💎. Weil es so wichtig ist, dass du PROMPT wirklich jeden Tag benutzt, bekommst du zusätzliche Edelsteine, wenn du keinen Tag auslässt. Du bekommst außerdem zusätzliche 💎, wenn du pünktlich alle Vokabeltests gemacht hast."),
              MarkdownBody(
                  data:
                      "Für deine Edelsteine bekommst du am Ende einen Gutschein und zwar mit mehr Guthaben, je mehr Edelsteine du gesammelt hast! Insgesamt bis zu 20 Euro."),
              MarkdownBody(
                  data:
                      "Alle paar Tage kannst du außerdem neue Hintergründe mit dem Monster, das du dir ausgesucht hast, in der App freischalten."),
              UIHelper.verticalSpaceMedium(),
              MarkdownBody(data: "# Neuigkeiten zu PROMPT"),
              MarkdownBody(
                  data:
                      "Neuigkeiten zu PROMPT veröffentlichen wir hier: https://indilearn.de/prompt/ Falls du eine Frage hast, kannst du auch immer gucken, ob sie vielleicht dort schon beantwortet wurde. Falls nicht, kannst du dich aber natürlich jederzeit an uns wenden. Schreibe uns dazu eine E-Mail an prompt@idea-frankfurt.eu"),
              UIHelper.verticalSpaceMedium(),
              MarkdownBody(data: "# Freiwilligkeit und Datenschutz"),
              MarkdownBody(
                  data:
                      "Du entscheidest selbst, ob du an der Studie teilnehmen möchtest. Du kannst jederzeit aufhören und musst das auch nicht begründen. Dir entstehen dadurch keine Nachteile. Die Angaben, die du während der Studie machst, werden von uns verschlüsselt. Das bedeutet, dass anstelle deines Namens eine Codenummer verwendet wird, sodass niemand weiß, dass das deine Daten sind. ")
            ])));
  }
}

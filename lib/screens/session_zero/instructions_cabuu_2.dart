import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class InstructionsCabuu2 extends StatelessWidget {
  const InstructionsCabuu2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var url = "https://youtu.be/k47mVYRf-yU";
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### Im Laufe unserer Studie sollst du cabuu auf eine ganz bestimmte Art benutzen. Deshalb ist es sehr wichtig, dass du dich genau an unsere Anleitung hältst."),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data:
                "### Unser Video, in dem wir alles erklären, schaust du dir am besten auf einem anderen Gerät (z.B. Computer) an, damit du gleichzeitig auf diesem Handy cabuu installieren kannst. Den Link zum Video findest du in der E-Mail, die wir an deine Eltern geschickt haben. Von dort kannst du ihn auf einem anderen Gerät öffnen. Hier ist der Link noch mal:"),
        UIHelper.verticalSpaceMedium(),
        Center(
            child: InkWell(
                child: MarkdownBody(data: "# **https://youtu.be/k47mVYRf-yU**"),
                onTap: () async {
                  if (await canLaunch(url)) {
                    await launch('https://youtu.be/k47mVYRf-yU');
                  }
                })),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data:
                "### Komme hierher zurück und klicke auf “Weiter”, wenn du damit fertig bist.")
      ],
    ));
  }
}

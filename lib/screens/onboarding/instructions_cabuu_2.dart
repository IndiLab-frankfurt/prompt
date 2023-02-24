import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                "In unserer Studie sollst du cabuu auf eine ganz bestimmte Art benutzen - wie erklären wir dir in unserem Erklärvideo. Schaue es auf einem anderen Gerät (z. B. Computer) an, damit du cabuu gleichzeitig auf deinem Handy installieren kannst."),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(
            data:
                "Der Link zum Video wurde an deine Eltern per E-Mail gesendet. Hier ist der Link nochmal:"),
        UIHelper.verticalSpaceMedium,
        Center(
            child: MarkdownBody(
                data: "# **https://youtu.be/k47mVYRf-yU**",
                selectable: true,
                onTapLink: (_, __, ___) async {
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString('https://youtu.be/k47mVYRf-yU');
                  }
                })),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(
            data:
                "Komme hierher zurück und klicke auf “Weiter”, wenn du damit fertig bist.")
      ],
    ));
  }
}

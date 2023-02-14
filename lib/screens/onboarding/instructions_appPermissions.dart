import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionsAppPermissions extends StatelessWidget {
  const InstructionsAppPermissions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### Du wirst als nächstes von der PROMPT App zu den Einstellungen deines Telefons geschickt. Das sieht dann ungefährt so aus: "),
        UIHelper.verticalSpaceMedium(),
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ],
            ),
            child: Image(
                image: AssetImage("assets/screenshots/appPermissions_1.png"))),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data:
                "### Wähle dort bitte 'PROMPT' aus und dann aktiviere auf dem nächsten Bildschirm die Option mit dem Schieberegler. So, wie du es auf dem nächsten Bild sehen kannst."),
        UIHelper.verticalSpaceMedium(),
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ],
            ),
            child: Image(
                image: AssetImage("assets/screenshots/appPermissions_2.png"))),
      ],
    ));
  }
}

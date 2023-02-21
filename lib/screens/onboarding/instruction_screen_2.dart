import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionScreen2 extends StatelessWidget {
  const InstructionScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                '### Wenn die Aussage "Ich lerne gerne Vokabeln" für dich überhaupt nicht stimmt, klickst auf die Antwort "trifft überhaupt nicht zu".'),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(
            data:
                '### Wenn die Aussage nur ein wenig für dich stimmt, aber eigentlich eher nicht, klickst du auf die Antwort “trifft eher nicht zu”.'),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(
            data:
                '### Wenn die Aussage für dich eher stimmt, aber doch nicht ganz oder nicht immer, klickst du auf die Antwort “trifft eher zu”.'),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(
            data:
                '### Wenn die Aussage für dich voll und ganz stimmt, klickst du auf die Antwort “trifft voll und ganz zu”.')
      ],
    ));
  }
}

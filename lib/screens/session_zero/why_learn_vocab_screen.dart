import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class WhyLearnVocabScreen extends StatefulWidget {
  WhyLearnVocabScreen({Key? key}) : super(key: key);

  @override
  _WhyLearnVocabScreenState createState() => _WhyLearnVocabScreenState();
}

class _WhyLearnVocabScreenState extends State<WhyLearnVocabScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: UIHelper.containerMargin,
      child: Column(
        children: [
          MarkdownBody(data: "### " + AppStrings.WhyVocab_ParagraphOne),
          UIHelper.verticalSpaceSmall(),
          MarkdownBody(data: "### " + AppStrings.WhyVocab_ParagraphTwo),
          UIHelper.verticalSpaceSmall(),
          TextField(
              minLines: 5,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText:
                    'Schreibe deine Antwort hier affe (Stichworte genügen)',
              )),
        ],
      ),
    );
  }
}

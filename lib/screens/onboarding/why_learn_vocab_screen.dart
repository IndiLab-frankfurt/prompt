import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:provider/provider.dart';

class WhyLearnVocabScreen extends StatefulWidget {
  WhyLearnVocabScreen({Key? key}) : super(key: key);

  @override
  _WhyLearnVocabScreenState createState() => _WhyLearnVocabScreenState();
}

class _WhyLearnVocabScreenState extends State<WhyLearnVocabScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<OnboardingViewModel>(context, listen: false);
    return Container(
      margin: UIHelper.containerMargin,
      child: ListView(
        children: [
          MarkdownBody(data: "### " + AppStrings.WhyVocab_ParagraphOne),
          UIHelper.verticalSpaceSmall,
          MarkdownBody(data: "### " + AppStrings.WhyVocab_ParagraphTwo),
          UIHelper.verticalSpaceSmall,
          TextField(
              controller: _controller,
              minLines: 5,
              maxLines: null,
              onChanged: (text) {
                vm.vocabValue = text;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                labelText:
                    'Schreibe deine Antwort hier auf (Stichworte genügen)',
              )),
        ],
      ),
    );
  }
}

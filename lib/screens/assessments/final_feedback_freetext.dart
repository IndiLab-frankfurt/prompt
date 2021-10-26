import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/morning_assessment_view_model.dart';
import 'package:provider/provider.dart';

class FinalFeedbackFreeText extends StatefulWidget {
  const FinalFeedbackFreeText({Key? key}) : super(key: key);

  @override
  _FinalFeedbackFreeTextState createState() => _FinalFeedbackFreeTextState();
}

class _FinalFeedbackFreeTextState extends State<FinalFeedbackFreeText> {
  TextEditingController _controllerGood = TextEditingController();
  TextEditingController _controllerBad = TextEditingController();
  TextEditingController _controllerFeedback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<MorningAssessmentViewModel>(context, listen: false);
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data: "### " + "Hier kannst du uns deine Meinung offen mitteilen"),
        UIHelper.verticalSpaceSmall(),
        MarkdownBody(data: "### " + "Das fand ich gut an der App"),
        TextField(
            controller: _controllerGood,
            minLines: 3,
            maxLines: null,
            onChanged: (text) {
              vm.finalFeedbackGood = text;
            },
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              labelText: '(Stichworte genügen)',
            )),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### " + "Das fand ich nicht so gut an der App"),
        TextField(
            controller: _controllerBad,
            minLines: 3,
            maxLines: null,
            onChanged: (text) {
              vm.finalFeedbackBad = text;
            },
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              labelText: '(Stichworte genügen)',
            )),
        MarkdownBody(
            data: "### " + "Möchtest du uns sonst noch etwas mitteilen?"),
        TextField(
            controller: _controllerFeedback,
            minLines: 3,
            maxLines: null,
            onChanged: (text) {
              vm.finalFeedbackOpen = text;
            },
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              labelText: '(Stichworte genügen)',
            )),
      ],
    ));
  }
}

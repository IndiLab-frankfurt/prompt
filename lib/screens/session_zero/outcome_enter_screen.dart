import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/mental_contrasting_view_model.dart';
import 'package:provider/provider.dart';

class OutcomeEnterScreen extends StatefulWidget {
  OutcomeEnterScreen({Key? key}) : super(key: key);

  @override
  _OutcomeEnterScreenState createState() => _OutcomeEnterScreenState();
}

class _OutcomeEnterScreenState extends State<OutcomeEnterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<MentalContrastingViewModel>(context, listen: false);

    return Container(
      child: Column(
        children: [
          MarkdownBody(data: "### ${AppStrings.SessionZero_OutcomeEnter_1}"),
          UIHelper.verticalSpaceMedium(),
          Flexible(
            flex: 9,
            child: TextField(
                minLines: 5,
                maxLines: null,
                onChanged: (text) {
                  vm.outcome = text;
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
          ),
        ],
      ),
    );
  }
}

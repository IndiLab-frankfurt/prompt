import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/onboarding_instructionbubble.dart';
import 'package:provider/provider.dart';

class PlanCreationScreen extends StatefulWidget {
  PlanCreationScreen({Key? key}) : super(key: key);

  @override
  _PlanCreationScreenState createState() => _PlanCreationScreenState();
}

class _PlanCreationScreenState extends State<PlanCreationScreen> {
  TextEditingController _habitTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<OnboardingViewModel>(context);

    return Container(
        child: ListView(children: [
      MarkdownBody(data: "### " + AppStrings.PlanCreation_LetsCreatePlan),
      UIHelper.verticalSpaceSmall,
      MarkdownBody(
          data: "### " + AppStrings.PlanCreation_PlanCreationExplanation),
      UIHelper.verticalSpaceLarge,
      MarkdownBody(data: "### " + AppStrings.PlanCreation_CompleteThePlan),
      UIHelper.verticalSpaceMedium,
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).selectedRowColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              MarkdownBody(data: '### " Wenn ich  '),
              UIHelper.horizontalSpaceSmall,
              Expanded(
                child: TextField(
                    maxLines: 3,
                    minLines: 1,
                    controller: _habitTextController,
                    onChanged: (newText) {
                      vm.plan = newText;
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        fillColor: Theme.of(context).selectedRowColor,
                        filled: true,
                        hintText: '   ...'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              MarkdownBody(data: '### ,'),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          MarkdownBody(data: '### dann lerne ich mit cabuu! "'),
        ]),
      )
    ]));
  }

  @override
  void initState() {
    super.initState();
    _habitTextController.text =
        Provider.of<OnboardingViewModel>(context, listen: false)
            .plan
            .replaceFirst("Wenn ich ", "")
            .replaceFirst(", dann lerne ich mit cabuu!", "");
  }
}

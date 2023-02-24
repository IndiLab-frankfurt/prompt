import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:provider/provider.dart';

class InstructionsCabuu1 extends StatelessWidget {
  const InstructionsCabuu1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late var vm = Provider.of<OnboardingViewModel>(context);
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### Jetzt zeigen wir dir, wie du deinen cabuu-Zugang aktivierst und die Vokabeln eingibst."),
        UIHelper.verticalSpaceSmall,
        MarkdownBody(data: "### Dein Cabuu Code lautet:"),
        UIHelper.verticalSpaceSmall,
        Center(child: MarkdownBody(data: '> # ' + vm.cabuuCode)),
        UIHelper.verticalSpaceSmall,
        MarkdownBody(
            data:
                "### Schreibe dir diesen Code auf. Du brauchst ihn gleich, um cabuu freizuschalten."),
        UIHelper.verticalSpaceLarge,
        UIHelper.verticalSpaceMedium,
      ],
    ));
  }
}

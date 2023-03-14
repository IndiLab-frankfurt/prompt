import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:intl/intl.dart';

class InstructionsCabuu2 extends StatelessWidget {
  const InstructionsCabuu2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var url = "https://youtu.be/_OlPiLu949U";
    late var vm = Provider.of<OnboardingViewModel>(context);
    var format = new DateFormat("dd.MM.yyyy");
    var targetDate = format.format(DateTime.now().add(Duration(days: 21)));
    return Container(
        child: ListView(
      children: [
        MarkdownBody(data: S.of(context).instructionsCabuu2Paragraph1),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(data: S.of(context).instructionsCabuuLink),
        UIHelper.verticalSpaceMedium,
        Center(
            child: MarkdownBody(
                data: "## **$url**",
                selectable: true,
                onTapLink: (_, __, ___) async {
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                  }
                })),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(data: S.of(context).instructionsCabuuWriteCode),
        UIHelper.verticalSpaceMedium,
        Center(child: MarkdownBody(data: "## **${vm.cabuuCode}**")),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(data: S.of(context).instructionsCabuuWriteDate),
        UIHelper.verticalSpaceSmall,
        Center(child: MarkdownBody(data: "## **$targetDate**")),
        UIHelper.verticalSpaceSmall,
        MarkdownBody(data: S.of(context).instructionsCabuu2Finish)
      ],
    ));
  }
}

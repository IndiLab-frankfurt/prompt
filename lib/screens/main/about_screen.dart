import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PromptAppBar(
          showBackButton: true,
        ),
        drawer: PromptDrawer(),
        body: Container(
            margin: UIHelper.containerMargin,
            child: ListView(children: [
              Text(
                S.of(context).aboutScreen_title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              UIHelper.verticalSpaceMedium,
              Text(S.of(context).aboutScreen_p1),
              UIHelper.verticalSpaceMedium,
              Text(S.of(context).aboutScreen_p2),
              Image.asset("assets/illustrations/study_chart.png"),
              MarkdownBody(data: S.of(context).aboutScreen_p3),
            ])));
  }
}

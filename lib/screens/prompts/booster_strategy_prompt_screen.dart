import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class BoosterStrategyPromptScreen extends StatelessWidget {
  const BoosterStrategyPromptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          UIHelper.verticalSpaceLarge(),
          MarkdownBody(data: "# " + AppStrings.BoosterPrompt_Text)
        ],
      ),
    );
  }
}

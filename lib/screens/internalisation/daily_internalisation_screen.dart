import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/daily_internalisation_view_model.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:prompt/widgets/speech_bubble.dart';
import 'package:provider/provider.dart';

class DailyInternalisationScreen extends StatefulWidget {
  DailyInternalisationScreen({Key? key}) : super(key: key);

  @override
  _DailyInternalisationScreenState createState() =>
      _DailyInternalisationScreenState();
}

class _DailyInternalisationScreenState
    extends State<DailyInternalisationScreen> {
  late DailyInternalisationViewModel vm =
      Provider.of<DailyInternalisationViewModel>(context);

  late var internalisationScreen = ChangeNotifierProvider.value(
    value: vm.internalisation,
    child: EmojiInternalisationScreen(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: ,
      body: Container(
        margin: UIHelper.containerMargin,
        child: ListView(children: [
          UIHelper.verticalSpaceLarge(),
          MarkdownBody(data: "# " + AppStrings.ThinkAboutYourGoal),
          UIHelper.verticalSpaceMedium(),
          SpeechBubble(
              text: '"Ich will jeden Tag ein paar Vokabeln mit cabuu lernen!"'),
          UIHelper.verticalSpaceMedium(),
          internalisationScreen,
          UIHelper.verticalSpaceMedium(),
          Align(
            alignment: Alignment.bottomCenter,
            child: FullWidthButton(onPressed: () async {
              await Navigator.pushNamed(context, RouteNames.NO_TASKS);
            }),
          )
        ]),
      ),
    );
  }
}

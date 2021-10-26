import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/internalisation/internalisation_screen.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class BoosterStrategyPromptScreen extends StatefulWidget {
  final Duration waitingDuration;
  final OnCompletedCallback? onCompleted;
  const BoosterStrategyPromptScreen(
      {Key? key, required this.waitingDuration, this.onCompleted})
      : super(key: key);

  @override
  State<BoosterStrategyPromptScreen> createState() =>
      _BoosterStrategyPromptScreenState();
}

class _BoosterStrategyPromptScreenState
    extends State<BoosterStrategyPromptScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller =
      AnimationController(duration: widget.waitingDuration, vsync: this);
  late Animation<double> animation =
      animation = Tween<double>(begin: 0, end: 1).animate(controller);

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  void initTimer() {
    animation.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          this.widget.onCompleted!("");
        });
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          UIHelper.verticalSpaceMedium(),
          Image(
            image: AssetImage('assets/illustrations/distributed_calendar.png'),
          ),
          UIHelper.verticalSpaceMedium(),
          MarkdownBody(
              data: '# Lies dir den Lerntrick des Monsters genau durch:'),
          UIHelper.verticalSpaceSmall(),
          MarkdownBody(
              data:
                  '# Du kannst dir die Vokabeln am besten merken, wenn du jeden Tag lernst.'),
          UIHelper.verticalSpaceMedium(),
          LinearProgressIndicator(
            value: animation.value,
          ),
          UIHelper.verticalSpaceMedium(),
          Image(
            image: AssetImage(
                'assets/illustrations/distributed_mascot_shield.png'),
          ),
        ],
      ),
    );
  }
}

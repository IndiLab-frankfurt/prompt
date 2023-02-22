import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/internalisation/internalisation_screen.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:provider/provider.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/widgets/speech_bubble.dart';

class WaitingInternalisationScreen extends StatefulWidget {
  final Duration waitingDuration;
  final OnCompletedCallback? onCompleted;

  WaitingInternalisationScreen(this.waitingDuration,
      {Key? key, this.onCompleted})
      : super(key: key);

  @override
  _WaitingInternalisationScreenState createState() =>
      _WaitingInternalisationScreenState();
}

class _WaitingInternalisationScreenState
    extends State<WaitingInternalisationScreen>
    with SingleTickerProviderStateMixin {
  late InternalisationViewModel vm =
      Provider.of<InternalisationViewModel>(context, listen: false);
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
          vm.submit(InternalisationCondition.waiting, "");
          this.widget.onCompleted!("");
        });
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<InternalisationViewModel>(context, listen: false);

    return Container(
      margin: UIHelper.containerMargin,
      child: ListView(
        children: <Widget>[
          MarkdownBody(
              data:
                  "### Lies dir den Plan mindestens dreimal durch und merke ihn dir gut! Drücke dann auf weiter."),
          UIHelper.verticalSpaceMedium,
          SpeechBubble(text: '"${vm.plan}"'),
          UIHelper.verticalSpaceMedium,
          LinearProgressIndicator(
            value: animation.value,
          ),
          UIHelper.verticalSpaceMedium,
          // if (_done) _buildSubmitButton()
        ],
      ),
    );
  }
}

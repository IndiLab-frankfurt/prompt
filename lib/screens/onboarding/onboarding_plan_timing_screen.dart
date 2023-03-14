import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/plan_timing.dart';
import 'package:prompt/widgets/speech_bubble.dart';
import 'package:provider/provider.dart';

class OnboardingPlanTimingScreen extends StatefulWidget {
  const OnboardingPlanTimingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingPlanTimingScreenState createState() =>
      _OnboardingPlanTimingScreenState();
}

class _OnboardingPlanTimingScreenState
    extends State<OnboardingPlanTimingScreen> {
  final ConfettiController _controllerTopCenter =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    // wait a bit, then play the animation
    Future.delayed(const Duration(milliseconds: 500), () {
      _controllerTopCenter.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<OnboardingViewModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        children: [
          SpeechBubble(
            text: S.of(context).congratsMoreDiamonds("20"),
          ),
          _buildConfetti(),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(data: S.of(context).planTimingParagraph1),
          UIHelper.verticalSpaceMedium,
          Text(
            S.of(context).planTimingParagraph2,
          ),
          UIHelper.verticalSpaceMedium,
          ChangeNotifierProvider.value(
            value: vm.planTimingViewModel,
            builder: (context, child) => PlanTiming(),
          )
        ],
      ),
    );
  }

  _buildConfetti() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controllerTopCenter,
        blastDirection: pi / 2,
        maxBlastForce: 5, // set a lower max blast force
        minBlastForce: 2, // set a lower min blast force
        emissionFrequency: 0.1,
        numberOfParticles: 30, // a lot of particles at once
        gravity: 0.8,
      ),
    );
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }
}

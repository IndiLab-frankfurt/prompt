import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/speech_bubble.dart';

class RewardScreen1 extends StatefulWidget {
  const RewardScreen1({Key? key}) : super(key: key);

  @override
  State<RewardScreen1> createState() => _RewardScreen1State();
}

class _RewardScreen1State extends State<RewardScreen1> {
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
    return Container(
      child: ListView(
        children: [
          SpeechBubble(text: S.of(context).rewards1p1("5")),
          _buildConfettiTop(),
          UIHelper.verticalSpaceMedium,
          Text(S.of(context).rewards1p2),
          UIHelper.verticalSpaceMedium,
          Text(S.of(context).rewards1p3),
        ],
      ),
    );
  }

  _buildConfettiTop() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controllerTopCenter,
        blastDirection: pi / 2,
        maxBlastForce: 5,
        minBlastForce: 2,
        emissionFrequency: 0.1,
        numberOfParticles: 30,
        gravity: 0.9,
      ),
    );
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }
}

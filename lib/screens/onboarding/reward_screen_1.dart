import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
          UIHelper.verticalSpaceLarge,
          SpeechBubble(
            text: "Glückwunsch, du hast deine ersten 5 💎 verdient!",
          ),
          _buildConfettiTop(),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
            data: "## Jetzt haben wir erst mal ein paar Fragen an dich.",
          ),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
            data:
                "## Bitte beantworte alle Fragen ehrlich. Dir entstehen dadurch keine Nachteile.",
          ),
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
        maxBlastForce: 5, // set a lower max blast force
        minBlastForce: 2, // set a lower min blast force
        emissionFrequency: 0.1,
        numberOfParticles: 30, // a lot of particles at once
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

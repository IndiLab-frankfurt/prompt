import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class RewardDialog extends StatefulWidget {
  const RewardDialog({super.key});

  @override
  State<RewardDialog> createState() => _RewardDialogState();
}

class _RewardDialogState extends State<RewardDialog> {
  ConfettiController controller =
      ConfettiController(duration: Duration(seconds: 5));

  @override
  void initState() {
    super.initState();
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ConfettiWidget(
      confettiController: controller,
      blastDirection: pi / 2,
      maxBlastForce: 5, // set a lower max blast force
      minBlastForce: 2, // set a lower min blast force
      emissionFrequency: 0.1,
      numberOfParticles: 30, // a lot of particles at once
      gravity: 0.8,
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

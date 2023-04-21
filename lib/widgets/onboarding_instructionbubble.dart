import 'package:flutter/material.dart';

class OnboardingInstructionBubble extends StatelessWidget {
  final Widget child;

  const OnboardingInstructionBubble({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
              blurRadius: 2,
              offset: Offset(5.0, 2.0),
              color: Colors.black.withOpacity(.12))
        ],
      ),
      child: this.child,
    );
  }
}

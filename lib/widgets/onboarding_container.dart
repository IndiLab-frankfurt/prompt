import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';

class OnboardingContainer extends StatelessWidget {
  final Widget child;
  final DecorationImage? decorationImage;

  const OnboardingContainer(
      {super.key, required this.child, this.decorationImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          gradient: UIHelper.baseGradient, image: this.decorationImage),
      child: this.child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';

class OnboardingContainer extends StatelessWidget {
  final Widget child;
  final String? bgimg;

  const OnboardingContainer({super.key, required this.child, this.bgimg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          gradient: UIHelper.baseGradient,
          image: this.bgimg != null
              ? DecorationImage(
                  image: AssetImage(bgimg!),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter)
              : null),
      child: this.child,
    );
  }
}

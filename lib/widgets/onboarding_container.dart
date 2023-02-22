import 'package:flutter/material.dart';

class OnboardingContainer extends StatelessWidget {
  final Widget child;
  final DecorationImage? decorationImage;

  const OnboardingContainer(
      {super.key, required this.child, this.decorationImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image: this.decorationImage),
      child: this.child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prompt/shared/ui_helper.dart';

class OnboadingContainer extends StatelessWidget {
  final Widget child;
  final String? bgimg;

  const OnboadingContainer({super.key, required this.child, this.bgimg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
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

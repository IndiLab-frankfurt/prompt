import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';

class PromptSingleScreen extends StatelessWidget {
  final Widget child;
  final ImageProvider? backgroundImage;
  const PromptSingleScreen(
      {Key? key, this.backgroundImage, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getDecoration(),
      child: Scaffold(
          appBar: PromptAppBar(showBackButton: true),
          drawer: PromptDrawer(),
          body: Container(padding: EdgeInsets.all(10), child: this.child)),
    );
  }

  getDecoration() {
    if (this.backgroundImage != null) {
      return BoxDecoration(
          gradient: UIHelper.baseGradient,
          image: DecorationImage(
              image: this.backgroundImage!,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter));
    } else {
      return UIHelper.defaultBoxDecoration;
    }
  }
}

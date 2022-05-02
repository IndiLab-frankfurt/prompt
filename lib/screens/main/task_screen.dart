import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/prompt_appbar.dart';

class TaskScreen extends StatelessWidget {
  final Widget child;
  const TaskScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: UIHelper.defaultBoxDecoration,
        child: Scaffold(
            appBar: PromptAppBar(showBackButton: true),
            body: Container(
              child: child,
            )));
  }
}

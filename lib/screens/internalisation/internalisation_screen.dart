import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';

class InternalisationScreen extends StatefulWidget {
  InternalisationScreen({Key? key}) : super(key: key);

  @override
  _InternalisationScreenState createState() => _InternalisationScreenState();
}

class _InternalisationScreenState extends State<InternalisationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Text("Denk an dein Ziel:"),
          UIHelper.verticalSpaceMedium(),
          Text("Ich will jeden Tag eine Wurst essen!"),
          UIHelper.verticalSpaceMedium(),
          Text("Um dein Ziel zu erreichen, hast du folgenden Plan:"),
          Text("Wenn ich nach Hause komme, dann esse ich eine Wurst!")
        ],
      ),
    );
  }
}

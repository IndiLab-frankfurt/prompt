import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/mental_contrasting_view_model.dart';
import 'package:provider/provider.dart';

class ObstacleEnterScreen extends StatefulWidget {
  ObstacleEnterScreen({Key? key}) : super(key: key);

  @override
  _ObstacleEnterScreenState createState() => _ObstacleEnterScreenState();
}

class _ObstacleEnterScreenState extends State<ObstacleEnterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<MentalContrastingViewModel>(context, listen: false);
    var bgimg = "assets/illustrations/mascot_1_wall.png";
    return Container(
      decoration: BoxDecoration(
          gradient: UIHelper.baseGradient,
          image: DecorationImage(
              scale: 5.5,
              image: AssetImage(bgimg),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter)),
      child: ListView(
        children: [
          MarkdownBody(data: "### ${AppStrings.SessionZero_ObstacleEnter_1}"),
          UIHelper.verticalSpaceMedium(),
          Flexible(
            flex: 9,
            child: TextField(
                minLines: 5,
                maxLines: null,
                onChanged: (text) {
                  vm.obstacle = text;
                },
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  labelText:
                      'Schreibe deine Antwort hier auf (Stichworte genügen)',
                )),
          ),
        ],
      ),
    );
  }
}

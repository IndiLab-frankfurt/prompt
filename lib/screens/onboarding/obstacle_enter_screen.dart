import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/onboarding_container.dart';
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
    var bgimg = "assets/illustrations/mascot_1_wall.png";
    var vm = Provider.of<OnboardingViewModel>(context);
    return OnboardingContainer(
      decorationImage: DecorationImage(
          image: AssetImage(bgimg),
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter),
      child: ListView(
        children: [
          MarkdownBody(data: "${S.of(context).obstacleEnterP1}"),
          UIHelper.verticalSpaceMedium,
          TextField(
              minLines: 3,
              maxLines: null,
              onChanged: (text) {
                vm.planInputViewModelObstacle.input = text;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                labelText: S.of(context).labelTextWriteDownBulletPoints,
                helperText: S.of(context).obstacleOutcomeHelperText,
              )),
        ],
      ),
    );
  }
}

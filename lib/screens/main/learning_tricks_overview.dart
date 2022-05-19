import 'package:flutter/material.dart';
import 'package:prompt/screens/main/prompt_single_screen.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/learning_tricks_overview_view_model.dart';
import 'package:provider/provider.dart';

class LearningTricksOverviewScreen extends StatefulWidget {
  const LearningTricksOverviewScreen({Key? key}) : super(key: key);

  @override
  State<LearningTricksOverviewScreen> createState() =>
      _LearningTricksOverviewScreenState();
}

class _LearningTricksOverviewScreenState
    extends State<LearningTricksOverviewScreen> {
  late Future<bool> init = vm.initialize();
  late var vm = Provider.of<LearningTricksOverviewViewModel>(context);
  @override
  Widget build(BuildContext context) {
    return PromptSingleScreen(
      child: FutureBuilder(
        future: init,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return buildContent();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  buildContent() {
    return ListView(children: [
      UIHelper.verticalSpaceLarge(),
      Text(
        "Hier kannst du dir die alle Lerntricks noch mal anschauen.",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      UIHelper.verticalSpaceLarge(),
      buildNavButton(
          context, "Tipps für das Lernen ansehen", RouteNames.LEARNING_TIPS),
      buildNavButton(
          context, "Mache dir einen Plan", RouteNames.VIDEO_CREATEPLAN),
      if (!vm.distributedLearningNotSeen)
        buildNavButton(
            context, "Lerne verteilt", RouteNames.DISTRIBUTED_LEARNING),
      if (!vm.mentalConstratingNotSeen)
        buildNavButton(
            context, "Überwinde Hindernisse", RouteNames.MENTAL_CONTRASTING),
    ]);
  }

  buildNavButton(BuildContext context, String label, String route) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 80,
      child: (ElevatedButton(
        onPressed: () => {Navigator.pushNamed(context, route)},
        child: Text(label),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:provider/provider.dart';

typedef void OnCompletedCallback(String result);

class InternalisationScreen extends StatefulWidget {
  InternalisationScreen({Key? key}) : super(key: key);

  @override
  _InternalisationScreenState createState() => _InternalisationScreenState();
}

class _InternalisationScreenState extends State<InternalisationScreen> {
  late var vm = Provider.of<InternalisationViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Text(AppStrings.Internalisation_ThinkAboutYourGoal),
          UIHelper.verticalSpaceMedium(),
          // TODO: Replaceholder
          Text("Ich will jeden Tag Vokabeln lernen!"),
          UIHelper.verticalSpaceMedium(),
          Text(AppStrings.Internalisation_ToReachYourGoal),
          Text(vm.plan)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_page_screen.dart';
import 'package:prompt/screens/assessments/plan_input_screen.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/plan_input_view_model.dart';
import 'package:prompt/viewmodels/plan_prompt_view_model.dart';
import 'package:prompt/widgets/background_image_container.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';

class PlanPromptScreen extends StatefulWidget {
  PlanPromptScreen({super.key});

  @override
  State<PlanPromptScreen> createState() => _PlanPromptScreenState();
}

class _PlanPromptScreenState extends State<PlanPromptScreen> {
  late PlanPromptViewModel vm;
  List<Widget> _screens = [];
  @override
  void initState() {
    vm = Provider.of<PlanPromptViewModel>(context, listen: false);
    super.initState();
    for (var page in vm.pages) {
      if (page is InternalisationViewModel) {
        _screens.add(
            EmojiInternalisationScreen(vm: vm.internalisationViewmodelEmoji));
      }

      if (page is PlanInputViewModel) {
        _screens.add(PlanInputScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<PlanPromptViewModel>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        child: Scaffold(
            appBar: PromptAppBar(showBackButton: true),
            drawer: PromptDrawer(),
            extendBodyBehindAppBar: true,
            body: BackgroundImageContainer(
                child: MultiPageScreen(
              vm,
              _screens,
            ))),
      ),
    );
  }
}

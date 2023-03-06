import 'package:async/async.dart';
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

class PlanPromptScreen extends StatelessWidget {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  final PlanPromptViewModel vm;

  PlanPromptScreen({super.key, required this.vm});

  init(BuildContext context) async {
    return this._memoizer.runOnce(() async {
      List<Widget> _screens = [];

      for (var page in vm.pages) {
        if (page is InternalisationViewModel) {
          _screens.add(
              EmojiInternalisationScreen(vm: vm.internalisationViewmodelEmoji));
        }

        if (page is PlanInputViewModel) {
          _screens.add(PlanInputScreen());
        }
      }

      return _screens;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          child: Scaffold(
              appBar: PromptAppBar(showBackButton: true),
              drawer: PromptDrawer(),
              extendBodyBehindAppBar: true,
              body: ChangeNotifierProvider.value(
                value: vm,
                builder: (context, child) {
                  return FutureBuilder(
                    future: init(context),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return BackgroundImageContainer(
                            child: MultiPageScreen(
                          vm,
                          snapshot.data,
                        ));
                      } else if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              )),
        ));
  }
}

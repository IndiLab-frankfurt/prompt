import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/vocab_learn_timing_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';

class VocabLearnTimingScreen extends StatelessWidget {
  const VocabLearnTimingScreen({Key? key}) : super(key: key);
  // TODO: Finish when there is time
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<VocabLearnTimingViewModel>(context);
    var initialTime = vm.getStoredTime();
    return Container(
      decoration: UIHelper.defaultBoxDecoration,
      child: Scaffold(
        appBar: PromptAppBar(showBackButton: true),
        drawer: PromptDrawer(),
        body: Container(
            margin: UIHelper.containerMargin,
            child: Column(
              children: [
                MarkdownBody(
                    data:
                        "## Wann möchtest du an das Vokabellernen erinnert werden?"),
                UIHelper.verticalSpaceSmall(),
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: initialTime,
                    );
                    if (pickedTime != null) {
                      vm.setNewTime(pickedTime);
                    }
                  },
                  child: Text(vm.getStoredTime().format(context),
                      style: TextStyle(fontSize: 30)),
                ),
                // MarkdownBody(
                //     data:
                //         "### Wann möchtest du an das Vokabellernen erinnert werden?"),
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prompt/screens/main/prompt_single_screen.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/vocab_learn_timing_view_model.dart';
import 'package:provider/provider.dart';

class VocabLearnTimingScreen extends StatelessWidget {
  const VocabLearnTimingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<VocabLearnTimingViewModel>(context);
    var initialTime = vm.getStoredTime();

    return PromptSingleScreen(
      backgroundImage: AssetImage("assets/illustrations/mascot_1_watch.PNG"),
      child: Container(
          margin: UIHelper.containerMargin,
          child: Column(
            children: [
              Text(
                "Wann möchtest du an das Vokabellernen erinnert werden?",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpaceMedium(),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: initialTime,
                    cancelText: "Abbrechen",
                    confirmText: "Speichern",
                    helpText: "Bitte wähle eine Uhrzeit aus.",
                  );
                  if (pickedTime != null) {
                    vm.setNewTime(pickedTime);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Text(vm.getStoredTime().format(context),
                      style: TextStyle(fontSize: 30)),
                ),
              ),
              // MarkdownBody(
              //     data:
              //         "### Wann möchtest du an das Vokabellernen erinnert werden?"),
            ],
          )),
    );
  }
}

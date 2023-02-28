import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/speech_bubble.dart';
import 'package:prompt/widgets/time_picker_grid_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlanTimingScreen extends StatefulWidget {
  const PlanTimingScreen({Key? key}) : super(key: key);

  @override
  _PlanTimingScreenState createState() => _PlanTimingScreenState();
}

class _PlanTimingScreenState extends State<PlanTimingScreen> {
  final ConfettiController _controllerTopCenter =
      ConfettiController(duration: const Duration(seconds: 2));
  late final vm = Provider.of<OnboardingViewModel>(context, listen: false);
  TextEditingController _timeDisplayController =
      TextEditingController(text: "18 Uhr");

  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    // wait a bit, then play the animation
    Future.delayed(const Duration(milliseconds: 500), () {
      _controllerTopCenter.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          SpeechBubble(
            text: AppLocalizations.of(context)!.congratsMoreDiamonds("20"),
          ),
          _buildConfetti(),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
              data: AppLocalizations.of(context)!.planTimingParagraph1),
          UIHelper.verticalSpaceMedium,
          Text(
            AppLocalizations.of(context)!.planTimingParagraph2,
          ),
          UIHelper.verticalSpaceMedium,
          buildTimeSelector()
        ],
      ),
    );
  }

  buildTimeSelector() {
    return TextField(
      controller: _timeDisplayController,
      readOnly: true,
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return TimePickerGridDialog();
            }).then((value) => _onChanged(value));
      },
      // style: Theme.of(context).textTheme.headline3,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: "Uhrzeit",
        suffixIcon: Icon(Icons.access_time),
        hintText: "Uhrzeit",
      ),
    );
  }

  _onChanged(TimeOfDay? selectedValue) {
    if (selectedValue == null) {
      return;
    }
    setState(() {
      _timeDisplayController.text = selectedValue.format(context);
      vm.savePlanTiming(selectedValue.format(context));
    });
  }

  _buildConfetti() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controllerTopCenter,
        blastDirection: pi / 2,
        maxBlastForce: 5, // set a lower max blast force
        minBlastForce: 2, // set a lower min blast force
        emissionFrequency: 0.1,
        numberOfParticles: 30, // a lot of particles at once
        gravity: 0.8,
      ),
    );
  }
}

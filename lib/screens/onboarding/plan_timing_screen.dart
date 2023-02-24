import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/time_picker_grid_dialog.dart';
import 'package:provider/provider.dart';
import 'package:prompt/shared/app_strings.dart';

class PlanTimingScreen extends StatefulWidget {
  const PlanTimingScreen({Key? key}) : super(key: key);

  @override
  _PlanTimingScreenState createState() => _PlanTimingScreenState();
}

class _PlanTimingScreenState extends State<PlanTimingScreen> {
  late final vm = Provider.of<OnboardingViewModel>(context, listen: false);
  TextEditingController _timeDisplayController =
      TextEditingController(text: "18 Uhr");

  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          // SpeechBubble(text: vm.plan),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(data: "### " + AppStrings.PlanTiming_Paragraph1),
          UIHelper.verticalSpaceMedium,
          Text(
            AppStrings.PlanTiming_Paragraph2,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          UIHelper.verticalSpaceMedium,
          buildTimeSelector()
        ],
      ),
    );
  }

  buildTimeSelector() {
    // var selectTime = () async {
    //   TimeOfDay? time = await showTimePicker(
    //     initialTime: TimeOfDay(hour: 18, minute: 0),
    //     context: context,
    //     errorInvalidText:
    //         "Der Zeitpunkt muss zwischen 18 Uhr und 24 Uhr liegen",
    //     helpText: "Wähle die Uhrzeit für die Erinnerung aus",
    //     initialEntryMode: TimePickerEntryMode.dial,
    //     builder: (BuildContext context, Widget? child) {
    //       return MediaQuery(
    //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
    //         child: child!,
    //       );
    //     },
    //   );

    //   setState(() {
    //     if (time != null) {
    //       this.selectedTime = time;
    //     }
    //   });

    //   if (selectedTime != null) {
    //     final localizations = MaterialLocalizations.of(context);
    //     final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime!,
    //         alwaysUse24HourFormat: true);
    //     _timeDisplayController.text = formattedTimeOfDay;
    //     _onChanged(formattedTimeOfDay);
    //   }
    // };
    // Textfield to select time
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
      style: Theme.of(context).textTheme.headline3,
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
}

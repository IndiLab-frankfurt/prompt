import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:prompt/widgets/speech_bubble.dart';
import 'package:provider/provider.dart';
import 'package:prompt/shared/app_strings.dart';

class PlanTimingScreen extends StatefulWidget {
  const PlanTimingScreen({Key? key}) : super(key: key);

  @override
  _PlanTimingScreenState createState() => _PlanTimingScreenState();
}

class _PlanTimingScreenState extends State<PlanTimingScreen> {
  late final vm = Provider.of<SessionZeroViewModel>(context);
  TextEditingController _timeDisplayController =
      TextEditingController(text: "18 Uhr");

  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          SpeechBubble(text: vm.plan),
          UIHelper.verticalSpaceMedium(),
          MarkdownBody(data: "### " + AppStrings.PlanTiming_Paragraph1),
          UIHelper.verticalSpaceMedium(),
          Text(
            AppStrings.PlanTiming_Paragraph2,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          UIHelper.verticalSpaceMedium(),
          buildTimeSelector()
        ],
      ),
    );
  }

  buildTimeSelector() {
    var selectTime = () async {
      TimeOfDay? time = await showTimePicker(
        initialTime: TimeOfDay(hour: 18, minute: 0),
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      setState(() {
        if (time != null) {
          this.selectedTime = time;
        }
      });

      if (selectedTime != null) {
        final localizations = MaterialLocalizations.of(context);
        final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime!,
            alwaysUse24HourFormat: true);
        _timeDisplayController.text = formattedTimeOfDay;
        _onChanged(formattedTimeOfDay);
      }
    };
    // Textfield to select time
    return TextField(
      controller: _timeDisplayController,
      readOnly: true,
      onTap: () async {
        selectTime();
      },
      decoration: InputDecoration(
        labelText: "Uhrzeit",
        suffixIcon: Icon(Icons.access_time),
        hintText: "Uhrzeit",
      ),
    );

    // return InkWell(
    //   child: Row(
    //     children: <Widget>[
    //       Radio(
    //         groupValue: _groupValue,
    //         value: groupValue,
    //         onChanged: (value) {
    //           // FocusScope.of(context).unfocus();
    //           selectTime();
    //         },
    //       ),
    //       Expanded(
    //         child: MarkdownBody(
    //           data: text,
    //         ),
    //       )
    //     ],
    //   ),
    //   onTap: () async {
    //     selectTime();
    //   },
    // );
  }

  _onChanged(String selectedValue) {
    setState(() {
      vm.saveQuestionnaireResponse("planTiming", "planTiming", selectedValue);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:prompt/widgets/speech_bubble.dart';
import 'package:provider/provider.dart';

class PlanTimingScreen extends StatefulWidget {
  const PlanTimingScreen({Key? key}) : super(key: key);

  @override
  _PlanTimingScreenState createState() => _PlanTimingScreenState();
}

class _PlanTimingScreenState extends State<PlanTimingScreen> {
  late final vm = Provider.of<SessionZeroViewModel>(context);
  int _groupValue = -1;

  TimeOfDay? selectedTime;

  buildRegularItem(int groupValue, String text) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Radio(
            groupValue: _groupValue,
            value: groupValue,
            onChanged: (value) {
              if (value is int) {
                _onChanged(value, groupValue.toString());
              }
            },
          ),
          Expanded(
            child: MarkdownBody(
              data: text,
            ),
          )
        ],
      ),
      onTap: () {
        _onChanged(groupValue, groupValue.toString());
      },
    );
  }

  buildTimeItem(int groupValue, String text) {
    var selectTime = () async {
      TimeOfDay? time = await showTimePicker(
        initialTime: TimeOfDay.now(),
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
        final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime!);

        _onChanged(groupValue, formattedTimeOfDay);
      }
    };

    return InkWell(
      child: Row(
        children: <Widget>[
          Radio(
            groupValue: _groupValue,
            value: groupValue,
            onChanged: (value) {
              // FocusScope.of(context).unfocus();
              selectTime();
            },
          ),
          Expanded(
            child: MarkdownBody(
              data: text,
            ),
          )
        ],
      ),
      onTap: () async {
        selectTime();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var timeDisplay = "Drücke hier um eine Uhrzeit auszuwählen.";
    if (selectedTime != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime!,
          alwaysUse24HourFormat: true);
      timeDisplay = "um $formattedTimeOfDay";
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SpeechBubble(text: vm.planCreationViewModel.plan),
            UIHelper.verticalSpaceMedium(),
            MarkdownBody(data: "### Um wie viel Uhr passiert das ungefähr?"),
            UIHelper.verticalSpaceMedium(),
            buildTimeItem(1, timeDisplay),
            buildRegularItem(6, "Ist jeden Tag ganz unterschiedlich"),
            buildRegularItem(7, "Weiß ich nicht"),
          ],
        ),
      ),
    );
  }

  _onChanged(int groupValue, String selectedValue) {
    setState(() {
      _groupValue = groupValue;

      vm.setAssessmentResult(
          "planTiming", groupValue.toString(), selectedValue);
    });
  }
}

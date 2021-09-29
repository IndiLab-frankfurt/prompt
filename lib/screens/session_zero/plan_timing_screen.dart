import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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

  buildRegularItem(int groupValue, String text) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Radio(
            groupValue: _groupValue,
            value: groupValue,
            onChanged: (value) {
              // FocusScope.of(context).unfocus();
              if (value is int) {
                // _onChanged(value, groupValue.toString());
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
        // _onChanged(groupValue, groupValue.toString());
      },
    );
  }

  buildTimeItem(int groupValue, String text) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Radio(
            groupValue: _groupValue,
            value: groupValue,
            onChanged: (value) {
              // FocusScope.of(context).unfocus();
              if (value is int) {
                // _onChanged(value, groupValue.toString());
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
        Future<TimeOfDay?> selectedTime = showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SpeechBubble(text: vm.plan),
          buildTimeItem(1, "Zu einer bestimmten Uhrzeit"),
          buildRegularItem(2, "Zwischen 6 und 8 Uhr morgens"),
          buildRegularItem(3, "Zwischen 10 und 12 Uhr morgens"),
          buildRegularItem(4, "Zwischen 12 und 14 Uhr morgens"),
          buildRegularItem(5, "Zwischen 14 und 16 Uhr morgens"),
          buildRegularItem(6, "Zwischen 16 und 18 Uhr morgens"),
          buildRegularItem(6, "Ist jeden Tag ganz unterschiedlich"),
          buildRegularItem(7, "Weiß ich nicht"),
        ],
      ),
    );
  }
}

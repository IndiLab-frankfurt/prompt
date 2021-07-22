import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class PlanCreationScreen extends StatefulWidget {
  PlanCreationScreen({Key? key}) : super(key: key);

  @override
  _PlanCreationScreenState createState() => _PlanCreationScreenState();
}

enum PlanCreationScreenState { enterHabit, selectTime, before, after, neither }

class _PlanCreationScreenState extends State<PlanCreationScreen> {
  TextEditingController _habitTextController = new TextEditingController();

  PlanCreationScreenState _screenState = PlanCreationScreenState.enterHabit;
  @override
  Widget build(BuildContext context) {
    Widget childWidget = buildEnterHabit();

    switch (_screenState) {
      case PlanCreationScreenState.enterHabit:
        childWidget = buildEnterHabit();
        break;
      case PlanCreationScreenState.selectTime:
        childWidget = buildEnterHabit();
        break;
      case PlanCreationScreenState.before:
        // TODO: Handle this case.
        break;
      case PlanCreationScreenState.after:
        // TODO: Handle this case.
        break;
      case PlanCreationScreenState.neither:
        // TODO: Handle this case.
        break;
    }

    return Container(
      child: childWidget,
    );
  }

  Widget buildEnterHabit() {
    return ListView(children: [
      MarkdownBody(data: "### Last und jetzt zusammen einen Plan erstellen!"),
      UIHelper.verticalSpaceMedium(),
      MarkdownBody(
          data:
              "### Überlege dir etwas, das du jeden Tag tust, möglichst auch am Wochenende. Schreibe es in 1-3 Stichworten auf:"),
      TextField(
        controller: _habitTextController,
        onChanged: (newText) {
          // _habitTextController. = newText;
        },
      ),
      ElevatedButton(
          onPressed: () {
            setState(() {
              _screenState = PlanCreationScreenState.selectTime;
            });
          },
          child: Text("Weiter"))
    ]);
  }

  Widget buildBeforeAfterNo() {
    return ListView(children: [
      Text(_habitTextController.text),
      Text("Hast du davor oder danach direkt Zeit, um mit cabuu zu lernen?"),
      ElevatedButton(
        child: Text("Davor"),
        onPressed: () {
          setState(() {
            _screenState = PlanCreationScreenState.before;
          });
        },
      ),
      ElevatedButton(
          child: Text("Danach"),
          onPressed: () {
            _screenState = PlanCreationScreenState.after;
          }),
      ElevatedButton(
        child: Text("Weder noch"),
        onPressed: () {
          _screenState = PlanCreationScreenState.neither;
        },
      )
    ]);
  }
}

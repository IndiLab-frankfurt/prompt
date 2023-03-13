import 'package:flutter/material.dart';
import 'package:prompt/models/alert_request.dart';
import 'package:prompt/models/alert_response.dart';
import 'package:prompt/models/reward_request.dart';
import 'package:prompt/services/dialog_service.dart';
import 'package:prompt/services/locator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogManager extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final Widget child;
  DialogManager({required this.child});
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();
  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
    _dialogService.registerRewardDialogListener(_showRewardDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    Alert(
        context: context,
        title: request.title,
        desc: request.description,
        closeFunction: () =>
            _dialogService.dialogComplete(AlertResponse(confirmed: false)),
        buttons: [
          DialogButton(
            child: Text('Ok'),
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(confirmed: true));
              Navigator.of(context).pop();
            },
          )
        ]).show();
  }

  void _showRewardDialog(RewardRequest request) {
    Alert(
        context: context,
        title: "Glückwunsch!",
        closeFunction: () =>
            _dialogService.dialogComplete(AlertResponse(confirmed: false)),
        content: Column(children: [
          Text(
            "💎",
            style: TextStyle(fontSize: 50),
          ),
          Text("Du hast ${request.score} Punkte verdient!",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
        ]),
        buttons: [
          DialogButton(
            child: Text('Ok'),
            color: Theme.of(context).primaryColorLight,
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(confirmed: true));
              Navigator.of(context).pop();
            },
          )
        ]).show();
  }
}

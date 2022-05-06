import 'package:flutter/material.dart';

class RewardDialog extends StatefulWidget {
  final int score;
  const RewardDialog({Key? key, required this.score}) : super(key: key);

  @override
  State<RewardDialog> createState() => _RewardDialogState();
}

class _RewardDialogState extends State<RewardDialog> {
  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            side: BorderSide(color: Colors.blue)),
        title: Text('Glückwunsch!'),
        content: Container(
          height: 120,
          child: Column(
            children: [
              Text('Du hast', style: TextStyle(fontSize: 20)),
              Text('${this.widget.score} 💎', style: TextStyle(fontSize: 30)),
              Text('bekommen!', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _dismissDialog(context);
            },
            child: Text('Weiter', style: TextStyle(fontSize: 20)),
          )
        ],
      ),
    );
  }
}

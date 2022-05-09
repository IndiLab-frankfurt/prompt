import 'package:flutter/material.dart';

class SingleLearningTipDialog extends StatelessWidget {
  const SingleLearningTipDialog({Key? key}) : super(key: key);
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
              Text('10 💎', style: TextStyle(fontSize: 30)),
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

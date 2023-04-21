import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final Function? onPressed;
  final String text;
  const DashboardButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: 400, minHeight: 80),
        child: OutlinedButton(
          onPressed: () async {
            if (this.onPressed != null) {
              this.onPressed!();
            }
          },
          child: Text(
            this.text,
            style: TextStyle(color: Colors.black),
          ),
          style: OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorLight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              side: BorderSide(width: 1.0, color: Colors.black)),
        ));
  }
}

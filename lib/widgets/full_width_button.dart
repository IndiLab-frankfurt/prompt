import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final double height;

  FullWidthButton(
      {super.key,
      required this.onPressed,
      this.text = "Abschicken",
      this.height = 60});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: this.height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0)),
          ),
          child: Text(this.text, style: TextStyle(fontSize: 20)),
        ));
  }
}

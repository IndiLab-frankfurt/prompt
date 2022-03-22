import 'package:flutter/material.dart';

class WhoAreYouScreen extends StatelessWidget {
  const WhoAreYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Text('Wer bist du?'),
          // Create four toggle buttons below each other
          // with the same group value.
          ToggleButtons(
            borderColor: Colors.black,
            selectedBorderColor: Colors.black,
            fillColor: Colors.white,
            selectedColor: Colors.white,
            borderWidth: 1,
            children: [
              Text('Schüler, Schülerin'),
              Text('Lehrkraft'),
              Text('Elternteil'),
              Text('Andere'),
            ],
            onPressed: (int index) {
              print(index);
            },
            isSelected: [true, false, false, false],
          ),
        ],
      ),
    );
  }
}

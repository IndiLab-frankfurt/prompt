import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';

class MascotSelectionScreen extends StatelessWidget {
  const MascotSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        Text(AppStrings.SelectionOfMascot),
        IconButton(
          icon: Image.asset('assets/icons/brain.png'),
          iconSize: 50,
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset('assets/icons/anatomy.png'),
          iconSize: 50,
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset('assets/icons/mehappy.png'),
          iconSize: 50,
          onPressed: () {},
        )
      ],
    ));
  }
}

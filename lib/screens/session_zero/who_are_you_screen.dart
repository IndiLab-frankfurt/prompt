import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class WhoAreYouScreen extends StatefulWidget {
  const WhoAreYouScreen({Key? key}) : super(key: key);

  @override
  State<WhoAreYouScreen> createState() => _WhoAreYouScreenState();
}

class _WhoAreYouScreenState extends State<WhoAreYouScreen> {
  List<bool> isSelected = [false, false, false, false];
  static List<String> roles = [
    'Schüler, Schülerin',
    'Lehrkraft',
    'Elternteil',
    'Andere',
  ];

  Widget toggleButton(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);

    List<Widget> buttons = [];
    for (int i = 0; i < roles.length; i++) {
      buttons.add(toggleButton(context, roles[i]));
    }

    return Container(
      child: ListView(
        children: [
          Text('Wer bist du?'),
          // Create four toggle buttons below each other
          // with the same group value.
          UIHelper.verticalSpaceLarge(),
          ToggleButtons(
            direction: Axis.vertical,
            borderColor: Colors.black,
            selectedBorderColor: Colors.orange,
            fillColor: Colors.white,
            selectedColor: Colors.black,
            borderWidth: 1,
            children: buttons,
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
              });
              vm.role = roles[index];
            },
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }
}

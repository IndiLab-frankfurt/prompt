import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';

typedef void HabitToggleButtonSelectionCallback(bool val);

class HabitToggleButtons extends StatefulWidget {
  final HabitToggleButtonSelectionCallback callback;
  final List<bool>? initialValues;

  const HabitToggleButtons(
      {Key? key, required this.callback, this.initialValues})
      : super(key: key);

  @override
  State<HabitToggleButtons> createState() => _HabitToggleButtonsState();
}

class _HabitToggleButtonsState extends State<HabitToggleButtons> {
  List<bool> isSelected = [false, false];
  bool disabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) {
      isSelected = widget.initialValues!;
    }
  }

  Widget toggleButton(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      toggleButton(context, "Ja"),
      toggleButton(context, "Nein"),
    ];

    disabled = isSelected[0];

    return Container(
      child: Column(
        children: [
          Text(
            "Hast du heute Vokabeln gelernt?",
            style: TextStyle(fontSize: 20),
          ),
          UIHelper.verticalSpaceSmall(),
          ToggleButtons(
            direction: Axis.horizontal,
            borderColor: Colors.black,
            selectedBorderColor: Colors.orange,
            fillColor: Colors.white,
            textStyle: TextStyle(fontSize: 20),
            selectedColor: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderWidth: 1,
            children: buttons,
            onPressed: (int index) {
              if (disabled) {
                return;
              }

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

              widget.callback(isSelected[0]);
            },
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }
}

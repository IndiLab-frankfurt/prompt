import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class MascotSelectionScreen extends StatefulWidget {
  const MascotSelectionScreen({Key? key}) : super(key: key);

  @override
  _MascotSelectionScreenState createState() => _MascotSelectionScreenState();
}

class _MascotSelectionScreenState extends State<MascotSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);
    return Container(
        child: ListView(
      children: [
        Text(AppStrings.SelectionOfMascot),
        IconButton(
          color: vm.selectedMascot == "1" ? Colors.orange : Colors.transparent,
          icon: Image.asset('assets/illustrations/mascot_1_bare.png'),
          iconSize: 50,
          onPressed: () {
            vm.selectedMascot = "1";
          },
        ),
        IconButton(
          color: vm.selectedMascot == "2" ? Colors.orange : Colors.transparent,
          icon: Image.asset('assets/icons/anatomy.png'),
          iconSize: 50,
          onPressed: () {
            vm.selectedMascot = "2";
          },
        ),
        IconButton(
          color: vm.selectedMascot == "3" ? Colors.orange : Colors.transparent,
          icon: Image.asset('assets/icons/mehappy.png'),
          iconSize: 50,
          onPressed: () {
            vm.selectedMascot = "3";
          },
        )
      ],
    ));
  }
}

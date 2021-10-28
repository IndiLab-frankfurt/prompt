import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class EndOfSessionScreen extends StatelessWidget {
  final double iconSize = 180;
  const EndOfSessionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);
    return ListView(
      children: [
        MarkdownBody(data: "" + AppStrings.EndofsessionText),
        MarkdownBody(data: "" + AppStrings.SelectionOfMascot),
        UIHelper.verticalSpaceMedium(),
        CircleAvatar(
          radius: 70,
          backgroundColor:
              vm.selectedMascot == "1" ? Colors.orange : Colors.grey,
          child: IconButton(
            icon: Image.asset('assets/illustrations/mascot_1_bare.png'),
            iconSize: iconSize,
            onPressed: () {
              vm.selectedMascot = "1";
            },
          ),
        ),
        CircleAvatar(
          radius: 70,
          backgroundColor:
              vm.selectedMascot == "2" ? Colors.orange : Colors.grey,
          child: IconButton(
            icon: Image.asset('assets/illustrations/mascot_2_selection.png'),
            iconSize: iconSize,
            onPressed: () {
              vm.selectedMascot = "2";
            },
          ),
        ),
        CircleAvatar(
          radius: 70,
          backgroundColor:
              vm.selectedMascot == "3" ? Colors.orange : Colors.grey,
          child: IconButton(
            color:
                vm.selectedMascot == "3" ? Colors.orange : Colors.transparent,
            icon: Image.asset('assets/illustrations/mascot_3_selection.png'),
            iconSize: 180,
            onPressed: () {
              vm.selectedMascot = "3";
            },
          ),
        )
      ],
    );
  }
}

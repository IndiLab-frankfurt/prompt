import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/change_mascot_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:provider/provider.dart';

class ChangeMascotScreen extends StatefulWidget {
  const ChangeMascotScreen({Key? key}) : super(key: key);

  @override
  _ChangeMascotScreenState createState() => _ChangeMascotScreenState();
}

class _ChangeMascotScreenState extends State<ChangeMascotScreen> {
  final double iconSize = 180;
  late ChangeMascotViewModel vm = Provider.of<ChangeMascotViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, RouteNames.NO_TASKS);
        return Future.value(true);
      },
      child: Scaffold(
          // drawer: PromptDrawer(),
          appBar: PromptAppBar(
            showBackButton: true,
          ),
          body: FutureBuilder(builder: (context, snapshot) {
            return Container(
                margin: UIHelper.containerMargin,
                child: ListView(
                  children: [
                    MarkdownBody(data: "# Hier kannst du dein Monster ändern"),
                    UIHelper.verticalSpaceMedium(),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: vm.selectedMascot == "1"
                          ? Colors.orange
                          : Colors.grey,
                      child: IconButton(
                        icon: Image.asset(
                            'assets/illustrations/mascot_1_bare.png'),
                        iconSize: iconSize,
                        onPressed: () {
                          vm.selectedMascot = "1";
                        },
                      ),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: vm.selectedMascot == "2"
                          ? Colors.orange
                          : Colors.grey,
                      child: IconButton(
                        icon: Image.asset(
                            'assets/illustrations/mascot_2_bare.png'),
                        iconSize: iconSize,
                        onPressed: () {
                          vm.selectedMascot = "2";
                        },
                      ),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: vm.selectedMascot == "3"
                          ? Colors.orange
                          : Colors.grey,
                      child: IconButton(
                        color: vm.selectedMascot == "3"
                            ? Colors.orange
                            : Colors.transparent,
                        icon: Image.asset(
                            'assets/illustrations/mascot_3_bare.png'),
                        iconSize: 180,
                        onPressed: () {
                          vm.selectedMascot = "3";
                        },
                      ),
                    )
                  ],
                ));
          })),
    );
  }
}

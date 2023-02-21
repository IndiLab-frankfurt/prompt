import 'package:flutter/material.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/ui_helper.dart';

class PromptAppBar extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const PromptAppBar({Key? key, this.title = "", this.showBackButton = false})
      : super(key: key);

  @override
  _PromptAppBarState createState() => _PromptAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(45);
}

class _PromptAppBarState extends State<PromptAppBar> {
  getRewardDisplay() {}

  @override
  void initState() {
    super.initState();
    var rewardService = locator.get<RewardService>();

    rewardService.retrieveScore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  AppBar build(BuildContext context) {
    var rewardService = locator.get<RewardService>();
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: widget.showBackButton,
      elevation: 0,
      actions: [
        // _buildAboutButton(),
        UIHelper.horizontalSpaceSmall,
        StreamBuilder(
            stream: rewardService.controller.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return TextButton(
                      onPressed: () {},
                      child: Text(
                        "${snapshot.data}💎",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[850]),
                      ));
                }
              }
              return Text("${rewardService.scoreValue}💎",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black));
            }),
        UIHelper.horizontalSpaceMedium
      ],
      title: Text(this.widget.title),
      centerTitle: true,
    );
  }
}

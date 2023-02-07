import 'package:flutter/material.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/widgets/version_info.dart';

class PromptDrawer extends StatelessWidget {
  PromptDrawer();

  _buildDrawerItem(
      {IconData icon = Icons.ac_unit,
      String text = "",
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Container(
              padding: EdgeInsets.only(top: 20, bottom: 10.0),
              child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/icon_256.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locator<UserService>().getUsername()),
                        // VersionInfo(),
                      ])),
            ),
          ),
          Divider(),
          _buildDrawerItem(
              icon: Icons.image_outlined,
              text: "Hintergrund ändern",
              onTap: () async {
                await Navigator.pushNamed(
                    context, AppScreen.RewardSelection.name);
              }),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Onboarding",
              onTap: () async {
                await Navigator.pushReplacementNamed(
                    context, AppScreen.Onboarding.name);
              }),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Questionnaire Test",
              onTap: () async {
                await Navigator.pushReplacementNamed(
                    context, AppScreen.AA_DidYouLearn.name);
              }),
        ],
      ),
    );
  }
}

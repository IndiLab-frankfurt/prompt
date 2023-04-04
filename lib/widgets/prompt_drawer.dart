import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/screens/main/scheduled_notifications_screen.dart';
import 'package:prompt/screens/main/text_compare_screen.dart';
import 'package:prompt/screens/main/theme_preview_screen.dart';
import 'package:prompt/services/dialog_service.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/enums.dart';

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
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        ListTile(
          title: Container(
            padding: EdgeInsets.only(top: 20, bottom: 10.0),
            child: Container(
                height: 140,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icons/icon_mascot1.png'),
                        fit: BoxFit.contain)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(locator<UserService>().getUsername()),
                    ])),
          ),
        ),
        Divider(),
        _buildDrawerItem(
            icon: Icons.dashboard_outlined,
            text: S.of(context).drawer_mainScreen,
            onTap: () async {
              await Navigator.pushNamed(context, AppScreen.MAINSCREEN.name);
            }),
        _buildDrawerItem(
            icon: Icons.image_outlined,
            text: S.of(context).drawer_changeBackground,
            onTap: () async {
              await Navigator.pushNamed(
                  context, AppScreen.REWARDSELECTION.name);
            }),
        _buildDrawerItem(
            icon: Icons.alarm,
            text: S.of(context).drawer_changeReminderTimes,
            onTap: () async {
              await Navigator.pushReplacementNamed(
                  context, AppScreen.PLANTIMINGCHANGE.name);
            }),
        _buildDrawerItem(
            icon: Icons.calendar_month_outlined,
            text: S.of(context).drawer_learningPlan,
            onTap: () async {
              await Navigator.pushReplacementNamed(
                  context, AppScreen.LEARNINGPLANCABUU.name);
            }),
        _buildDrawerItem(
            icon: Icons.info_outline_rounded,
            text: S.of(context).drawer_aboutPrompt,
            onTap: () async {
              await Navigator.pushReplacementNamed(
                  context, AppScreen.ABOUTPROMPT.name);
            }),
        _buildDrawerItem(
            icon: Icons.privacy_tip_outlined,
            text: S.of(context).drawer_dataPrivacy,
            onTap: () async {
              await Navigator.pushNamed(context, AppScreen.DATAPRIVACY.name);
            }),
        _buildDrawerItem(
            icon: Icons.account_circle,
            text: S.of(context).drawer_accountManagement,
            onTap: () async {
              await Navigator.pushNamed(
                  context, AppScreen.ACCOUNTMANAGEMENT.name);
            }),
        ...buildDebugItems(context)
      ]),
    );
  }

  List<Widget> buildDebugItems(BuildContext context) {
    return [
      Divider(),
      Text("DEBUG STUFF"),
      _buildDrawerItem(
          icon: Icons.add_box,
          text: "Login",
          onTap: () async {
            await Navigator.pushReplacementNamed(context, AppScreen.LOGIN.name);
          }),
      _buildDrawerItem(
          icon: Icons.add_box,
          text: "Onboarding",
          onTap: () async {
            await Navigator.pushReplacementNamed(
                context, AppScreen.ONBOARDING.name);
          }),
      _buildDrawerItem(
          icon: Icons.add_box,
          text: "Screen Select",
          onTap: () async {
            await Navigator.pushReplacementNamed(
                context, AppScreen.SCREENSELECT.name);
          }),
      _buildDrawerItem(
          icon: Icons.add_box,
          text: "Text Compare",
          onTap: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => TextCompareScreen()));
          }),
      _buildDrawerItem(
          icon: Icons.add_box,
          text: "Theme Overview",
          onTap: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => ThemePreviewScreen()));
          }),
      _buildDrawerItem(
          icon: Icons.add_box,
          text: "Scheduled Notifications",
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScheduledNotificationsScreen()));
          }),
    ];
  }
}

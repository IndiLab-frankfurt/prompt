import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/usage_stats/usage_stats_service.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/widgets/version_info.dart';
import 'package:intl/intl.dart';

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
                        VersionInfo(),
                        Text(
                            "Gruppe: ${locator.get<DataService>().getUserDataCache().group}"),
                        Text(
                            "Registrierung: ${DateFormat('yyyy-MM-dd').format(locator.get<DataService>().getUserDataCache().registrationDate)}"),
                        Text(
                            "Vor ${locator.get<DataService>().getUserDataCache().registrationDate.daysAgo()} tagen")
                      ])),
            ),
          ),
          Divider(),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Session 0",
              onTap: () async {
                await Navigator.pushNamed(context, RouteNames.SESSION_ZERO);
              }),
          // Divider(),
          // _buildDrawerItem(
          //     icon: Icons.add_box,
          //     text: "Kontroll Reminder",
          //     onTap: () async {
          //       await Navigator.pushNamed(context, RouteNames.REMINDER_DEFAULT);
          //     }),
          Divider(),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Befragung Morgens",
              onTap: () async {
                await Navigator.pushNamed(
                    context, RouteNames.ASSESSMENT_MORNING);
              }),
          Divider(),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Befragung Abends",
              onTap: () async {
                await Navigator.pushNamed(
                    context, RouteNames.ASSESSMENT_EVENING);
              }),
          Divider(),
          Column(
            children: [
              Text("Gruppe ändern"),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                initialValue: locator
                    .get<DataService>()
                    .getUserDataCache()
                    .group
                    .toString(),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    var group = int.parse(value);
                    if (group < 7) {
                      locator.get<DataService>().getUserDataCache().group =
                          group;
                    }
                  }
                },
              ),
              // ElevatedButton(onPressed: () {}, child: Text("Ändern"))
            ],
          ),
          Divider(),
          _buildDrawerItem(
              icon: Icons.calendar_today,
              text: "Registrierungsdatum setzen",
              onTap: () async {
                var regDate = locator
                    .get<DataService>()
                    .getUserDataCache()
                    .registrationDate;

                var picked = await showDatePicker(
                  context: context,
                  initialDate: regDate,
                  firstDate: DateTime.now().subtract(Duration(days: 40)),
                  lastDate: DateTime.now().add(Duration(days: 40)),
                  builder: (context, child) {
                    return Theme(
                      data:
                          ThemeData.dark(), // This will change to light theme.
                      child: child!,
                    );
                  },
                );

                if (picked != null && picked != regDate)
                  locator
                      .get<DataService>()
                      .getUserDataCache()
                      .registrationDate = picked;
              }),
          Divider(),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Login",
              onTap: () async {
                await Navigator.pushNamed(context, RouteNames.LOG_IN);
              }),
          Divider(),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Usage Stats",
              onTap: () async {
                var startDate = DateTime.now().subtract(Duration(days: 20));
                UsageStatsService.queryUsageStats(startDate, DateTime.now());
              }),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Usage Permissions",
              onTap: () async {
                UsageStatsService.grantUsagePermission();
              }),
          Divider(),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Scheduled Notifications",
              onTap: () async {
                var pending = await locator<NotificationService>()
                    .getPendingNotifications();

                print(pending);
              }),
        ],
      ),
    );
  }
}

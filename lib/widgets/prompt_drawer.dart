import 'package:flutter/material.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/route_names.dart';
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
                        VersionInfo(),
                        // Text(
                        //     "Gruppe: ${locator.get<DataService>().getUserDataCache().group}"),
                        // Text(
                        //     "Registrierung: ${DateFormat('yyyy-MM-dd').format(locator.get<DataService>().getUserDataCache().registrationDate)}"),
                        // Text(
                        //     "Vor ${locator.get<DataService>().getUserDataCache().registrationDate.daysAgo()} tagen")
                      ])),
            ),
          ),
          Divider(),
          _buildDrawerItem(
              icon: Icons.home,
              text: "Hauptbildschirm",
              onTap: () async {
                await Navigator.pushNamed(context, RouteNames.NO_TASKS);
              }),
          _buildDrawerItem(
              icon: Icons.image_outlined,
              text: "Hintergrund ändern",
              onTap: () async {
                await Navigator.pushNamed(context, RouteNames.REWARD_SELECTION);
              }),
          _buildDrawerItem(
              icon: Icons.edit_outlined,
              text: "Plan ändern",
              onTap: () async {
                await Navigator.pushNamed(context, RouteNames.EDIT_PLAN);
              }),
          _buildDrawerItem(
              icon: Icons.info_outline,
              text: "Lerntricks",
              onTap: () async {
                await Navigator.pushNamed(context, RouteNames.LEARNING_TIPS);
              }),
          _buildDrawerItem(
              icon: Icons.edit_notifications_outlined,
              text: "Zeitpunkt für Erinnerungen ändern",
              onTap: () async {
                await Navigator.pushNamed(
                    context, RouteNames.CHANGE_REMINDER_TIME);
              }),
          Divider(),
          _buildDrawerItem(
              icon: Icons.info_outlined,
              text: "Lerntip",
              onTap: () async {
                await Navigator.pushNamed(
                    context, RouteNames.SINGLE_LEARNING_TIP);
              }),
          // _buildDrawerItem(
          //     icon: Icons.add_box,
          //     text: "AutoRegistrierung",
          //     onTap: () async {
          //       await Navigator.pushReplacementNamed(
          //           context, RouteNames.RANDOM_LOGIN);
          //     }),
          // _buildDrawerItem(
          //     icon: Icons.add_box,
          //     text: "Plan Reminder",
          //     onTap: () async {
          //       await Navigator.pushNamed(context, RouteNames.PLAN_REMINDER);
          //     }),
          // Divider(),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Session 0",
              onTap: () async {
                await Navigator.pushNamed(context, RouteNames.SESSION_ZERO);
              }),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Outcomes/Obstacles",
              onTap: () async {
                await Navigator.pushNamed(
                    context, RouteNames.MENTAL_CONTRASTING);
              }),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Verteiltes Lernen",
              onTap: () async {
                await Navigator.pushNamed(
                    context, RouteNames.DISTRIBUTED_LEARNING);
              }),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Delete Last Date",
              onTap: () async {
                var ds = locator.get<DataService>();
                ds.deleteLastDateLearned();
              }),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Trigger Plan Reminder in 1 min.",
              onTap: () async {
                // create datetime one minute from now
                var now = DateTime.now();
                var oneMinuteFromNow = now.add(Duration(minutes: 1));
                // set reminder
                locator
                    .get<NotificationService>()
                    .schedulePlanReminder(oneMinuteFromNow);
              }),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Plan Reminder",
              onTap: () async {
                await Navigator.pushNamed(context, RouteNames.PLAN_REMINDER);
              }),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Delete all scheduled reminders",
              onTap: () async {
                locator.get<NotificationService>().clearPendingNotifications();
              }),
          // Divider(),
          // Column(
          //   children: [
          //     Text("Gruppe ändern"),
          //     TextFormField(
          //       textAlign: TextAlign.center,
          //       keyboardType: TextInputType.number,
          //       maxLength: 1,
          //       initialValue: locator
          //           .get<DataService>()
          //           .getUserDataCache()
          //           .group
          //           .toString(),
          //       onChanged: (value) {
          //         if (value.isNotEmpty) {
          //           var group = int.parse(value);
          //           if (group <= 7) {
          //             locator.get<DataService>().getUserDataCache().group =
          //                 group;
          //           }
          //         }
          //       },
          //     ),
          //     // ElevatedButton(onPressed: () {}, child: Text("Ändern"))
          //   ],
          // ),
          // Divider(),
          // _buildDrawerItem(
          //     icon: Icons.calendar_today,
          //     text: "Registrierungsdatum setzen",
          //     onTap: () async {
          //       var regDate = locator
          //           .get<DataService>()
          //           .getUserDataCache()
          //           .registrationDate;

          //       var picked = await showDatePicker(
          //         context: context,
          //         initialDate: regDate,
          //         firstDate: DateTime.now().subtract(Duration(days: 120)),
          //         lastDate: DateTime.now().add(Duration(days: 120)),
          //         builder: (context, child) {
          //           return Theme(
          //             data:
          //                 ThemeData.dark(), // This will change to light theme.
          //             child: child!,
          //           );
          //         },
          //       );

          //       if (picked != null) {
          //         locator
          //             .get<DataService>()
          //             .getUserDataCache()
          //             .registrationDate = picked;
          //       }

          //       await Navigator.pushReplacementNamed(
          //           context, RouteNames.NO_TASKS);
          //     }),
          // Divider(),
          // _buildDrawerItem(
          //     icon: Icons.add_box,
          //     text: "Login",
          //     onTap: () async {
          //       await Navigator.pushReplacementNamed(
          //           context, RouteNames.LOG_IN);
          //     }),
          // Divider(),
          // _buildDrawerItem(
          //     icon: Icons.add_box,
          //     text: "Usage Stats",
          //     onTap: () async {
          //       var startDate = DateTime.now().subtract(Duration(days: 20));
          //       UsageStatsService.queryUsageStats(startDate, DateTime.now());
          //     }),
          // Column(
          //   children: [
          //     Text("Sesion 0 Schritt"),
          //     TextFormField(
          //       textAlign: TextAlign.center,
          //       keyboardType: TextInputType.number,
          //       maxLength: 2,
          //       initialValue: "",
          //       onChanged: (value) {
          //         if (value.isNotEmpty) {
          //           var group = int.parse(value);
          //           locator.get<DataService>().saveSessionZeroStep(group);
          //         }
          //       },
          //     ),
          //   ],
          // ),
          // Divider(),
          // _buildDrawerItem(
          //     icon: Icons.add_box,
          //     text: "Scheduled Notifications",
          //     onTap: () async {
          //       var pending = await locator<NotificationService>()
          //           .getPendingNotifications();

          //       print(pending);
          //     }),
        ],
      ),
    );
  }
}

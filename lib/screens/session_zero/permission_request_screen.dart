import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';

class PermissionRequestScreen extends StatelessWidget {
  const PermissionRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Text('Die App braucht die Erlaubnis, um Erinnerungen zu schicken',
          style: TextStyle(fontSize: 20)),
      UIHelper.verticalSpaceLarge(),
      Text(
          'Drücke auf "Okay", und erlaube der App dann, dir Benachrichtigungen zu schicken',
          style: TextStyle(fontSize: 20)),
      ElevatedButton(
          onPressed: () {
            AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
              if (!isAllowed) {
                // This is just a basic example. For real apps, you must show some
                // friendly dialog box before call the request method.
                // This is very important to not harm the user experience
                AwesomeNotifications().requestPermissionToSendNotifications();
              }
            });
          },
          child: Text("Okay"))
    ]));
  }
}

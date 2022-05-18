import 'package:flutter/material.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class PermissionRequestScreen extends StatelessWidget {
  const PermissionRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);
    return Container(
        child: Column(children: [
      Text('Die App braucht deine Erlaubnis, um Erinnerungen zu schicken.',
          style: TextStyle(fontSize: 20)),
      UIHelper.verticalSpaceLarge(),
      Text(
          'Drücke auf "Okay", und erlaube dann der App, dir Erinnerungen zu schicken. Sonst drücke auf "Weiter".',
          style: TextStyle(fontSize: 20)),
      ElevatedButton(
          onPressed: () {
            var notificationService = locator<NotificationService>();
            notificationService.requestPermissions().then((value) {
              if (value != null && value) {
                vm.submit();
              }
            });
          },
          child: Text("Okay"))
    ]));
  }
}

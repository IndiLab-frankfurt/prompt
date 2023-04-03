import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/widgets/prompt_drawer.dart';

class ScheduledNotificationsScreen extends StatelessWidget {
  const ScheduledNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var notificationService = locator<NotificationService>();
    return Scaffold(
        drawer: PromptDrawer(),
        body: FutureBuilder(
            future: notificationService.getPendingNotifications(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var pending = snapshot.data as List<PendingNotificationRequest>;
                return ListView.builder(
                  itemCount: pending.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(pending[index].title ?? ""),
                      subtitle: Text(pending[index].payload ?? ""),
                    );
                  },
                );
              } else {
                return Placeholder();
              }
            }));
  }
}

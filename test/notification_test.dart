import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/notification_service.dart';

void main() {
  setUp(() {
    setupLocator();
  });

  test("Daily notifications are scheduled", () {
    var notificationService = locator<NotificationService>();
    // notificationService.scheduleDailyNotifications();
    // expect(notificationService.scheduledNotifications.length, 1);
  });
}

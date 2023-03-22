// This is a basic Flutter widget test.
//
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/study_service.dart';

void main() {
  setUp(() {
    setupLocator();
  });

  test('Schedule daily reminders', () async {
    var studyService = locator.get<StudyService>();
    var dataService = locator.get<DataService>();

    // User started yesterday
    var daysRunning = 1;
    var startDate = DateTime.now().subtract(Duration(days: daysRunning));

    var mockUD = UserData(
      user: "test",
      group: "test",
      startDate: startDate,
    );

    dataService.setUserDataCache(mockUD);

    var ud = dataService.getUserDataCache();

    // Reminder time should be one hour into the future
    var oneHourFuture = DateTime.now().add(Duration(hours: 1));
    ud.reminderTime = oneHourFuture;
    dataService.setUserDataCache(ud);

    // Since it's the first day, but the first reminder is in the future, we should
    // 41 reminders, with the first one being in one hour today

    var scheduleTimes = studyService.getDailyScheduleTimes(ud.reminderTime!);

    expect(scheduleTimes.length, 41);
    var difference = scheduleTimes[0].difference(oneHourFuture);
    expect(difference.inMinutes, lessThan(2));
  });
}

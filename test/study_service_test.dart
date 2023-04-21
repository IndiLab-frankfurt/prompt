// This is a basic Flutter widget test.
//
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/study_service.dart';

void main() {
  setUpAll(() {
    setupLocator();
  });

  test('Schedule daily reminders', () async {
    var studyService = locator.get<StudyService>();
    var dataService = locator.get<DataService>();

    // User started yesterday
    var daysRunning = 1;
    var startDate = DateTime.now().subtract(Duration(days: daysRunning));

    var mockUD = UserData(
      username: "test",
      group: "test",
      startDate: startDate,
    );

    dataService.setUserDataCache(mockUD);

    var ud = dataService.getUserDataCache();

    // Reminder time should be one hour into the future
    var oneHourFuture = DateTime.now().add(Duration(hours: 1));
    ud.reminderTime = oneHourFuture;
    dataService.setUserDataCache(ud);

    // Since it's the first day, but the first reminder is in the future, we should have
    // 42 reminders, with the first one being in one hour today
    var scheduleTimes = studyService.getDailyScheduleTimes(ud.reminderTime!);

    expect(scheduleTimes.length, StudyService.DAILY_USE_DURATION.inDays);
    var difference = scheduleTimes[0].difference(oneHourFuture);
    expect(difference.inHours, lessThan(2));
  });

  test('Schedule daily reminders onboarding', () async {
    var studyService = locator.get<StudyService>();
    var dataService = locator.get<DataService>();

    var startDate = DateTime.now();

    var mockUD = UserData(
      username: "test",
      group: "test",
      startDate: startDate,
    );

    dataService.setUserDataCache(mockUD);

    var ud = dataService.getUserDataCache();

    // Reminder time should be at 6pm
    ud.reminderTime =
        DateTime(startDate.year, startDate.month, startDate.day, 18, 0, 0);
    dataService.setUserDataCache(ud);

    // It is day 0, we should have 41 reminders, with the first one being tomorrow at 6pm
    var scheduleTimes = studyService.getDailyScheduleTimes(ud.reminderTime!);

    expect(scheduleTimes.length, StudyService.DAILY_USE_DURATION.inDays);

    // first schedule should be 6pm tomorrow
    var firstSchedule =
        DateTime(startDate.year, startDate.month, startDate.day + 1, 18, 0, 0);
    var difference = scheduleTimes[0].difference(firstSchedule);
    expect(difference.inMinutes, lessThan(1));
  });

  test('Schedule vocab reminders', () async {
    var studyService = locator.get<StudyService>();
    var dataService = locator.get<DataService>();

    var startDate = DateTime.now();

    var mockUD = UserData(
      username: "test",
      group: "test",
      startDate: startDate,
    );

    dataService.setUserDataCache(mockUD);

    var scheduleTimes = studyService.getVocabScheduleTimes();

    expect(scheduleTimes.length, StudyService.VOCAB_TEST_DAYS.length);
  });
}

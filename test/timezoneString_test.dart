// This is a basic Flutter widget test.
//
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/shared/extensions.dart';

void main() {
  setUp(() {
    setupLocator();
  });

  test('Test timezone aware string', () async {
    // This test is a bit stupid because it does not work in all timezones
    var testTime = DateTime(2022, 11, 20, 13, 2, 44, 0, 0);
    var timeZoneAwareString = testTime.toTimeZoneAwareISOString();

    var timezoneoffset = testTime.timeZoneOffset.inHours;

    // Test probably does not work in all timezones, but that is okay because
    // the app is only for german children anyway
    var offsetHours = testTime.hour - timezoneoffset;
    // zero padding
    var offsetHoursString = offsetHours.toString().padLeft(2, '0');
    var compareString =
        "2022-11-20T$offsetHoursString:02:44.000Z+0$timezoneoffset:00";

    expect(timeZoneAwareString, compareString);
  });
}

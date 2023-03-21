import 'package:flutter/material.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/viewmodels/completable_page.dart';

class PlanTimingViewModel extends BaseViewModel with CompletablePageMixin {
  DataService dataService;
  StudyService studyService;
  TimeOfDay planTiming = TimeOfDay(hour: 18, minute: 0);
  String timeDisplay = "18:00";

  PlanTimingViewModel(
      {required String name,
      required this.dataService,
      required this.studyService}) {
    this.name = name;
    completed = true;
  }

  void savePlanTiming(TimeOfDay selectedValue) {
    planTiming = selectedValue;

    // convert the timeofday to datetime
    var now = DateTime.now();
    var dateTime = DateTime(
        now.year, now.month, now.day, selectedValue.hour, selectedValue.minute);

    dataService.saveUserDataProperty(
        "reminder_time", dateTime.toIso8601String());

    studyService.scheduleDailyReminders(dateTime);

    // pad the time with a 0 if it's less than 10
    var minuteDisplay = selectedValue.minute < 10
        ? "0${selectedValue.minute}"
        : selectedValue.minute;

    timeDisplay = "${selectedValue.hour}:$minuteDisplay";

    notifyListeners();
  }
}

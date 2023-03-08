import 'package:flutter/material.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class PlanTimingViewModel extends BaseViewModel {
  DataService _dataService;
  StudyService _studyService;
  TimeOfDay planTiming = TimeOfDay(hour: 18, minute: 0);
  String timeDisplay = "18:00";

  PlanTimingViewModel(this._dataService, this._studyService);

  void savePlanTiming(TimeOfDay selectedValue) {
    planTiming = selectedValue;

    // convert the timeofday to datetime
    var now = DateTime.now();
    var dateTime = DateTime(
        now.year, now.month, now.day, selectedValue.hour, selectedValue.minute);

    _dataService.saveUserDataProperty(
        "reminder_time", dateTime.toIso8601String());

    // pad the time with a 0 if it's less than 10
    var minuteDisplay = selectedValue.minute < 10
        ? "0${selectedValue.minute}"
        : selectedValue.minute;

    timeDisplay = "${selectedValue.hour}:$minuteDisplay";
    _studyService.scheduleDailyReminders(selectedValue);
    notifyListeners();
  }
}

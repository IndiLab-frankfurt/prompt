import 'package:flutter/material.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class VocabLearnTimingViewModel extends BaseViewModel {
  final DataService _dataService;
  final NotificationService _notificationService;

  VocabLearnTimingViewModel(this._dataService, this._notificationService);

  TimeOfDay getStoredTime() {
    var ud = _dataService.getUserDataCache();
    var time = ud.preferredReminderTime;
    return time;
  }

  void setNewTime(TimeOfDay newTime) {
    var ud = _dataService.getUserDataCache();
    ud.preferredReminderTime = newTime;
    _dataService.saveUserDataProperty(
        "preferredReminderTime", newTime.to24HourString());
    var dt = DateTime.now();
    var newDate =
        DateTime(dt.year, dt.month, dt.day, newTime.hour, newTime.minute);
    _notificationService.scheduleDailyReminder(
        newDate, NotificationService.ID_DAILY);

    notifyListeners();
  }
}

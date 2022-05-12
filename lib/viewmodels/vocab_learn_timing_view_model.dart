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

  void setNewTime(TimeOfDay newTime) async {
    var ud = _dataService.getUserDataCache();
    ud.preferredReminderTime = newTime;
    _dataService.saveUserDataProperty(
        "preferredReminderTime", newTime.to24HourString());
    var dt = DateTime.now();
    var newDate =
        DateTime(dt.year, dt.month, dt.day, newTime.hour, newTime.minute);
    await _notificationService.scheduleDailyReminder(
        newDate, NotificationService.ID_DAILY);

    // in order to reschedule the plan prompt, we need its previous date
    var scheduled = await _notificationService.getPendingNotifications();
    for (var s in scheduled) {
      if (s.content?.id == NotificationService.ID_PLAN_REMINDER) {
        var scheduleMap = s.schedule?.toMap();
        if (scheduleMap != null) {
          var now = DateTime.now();
          var month = scheduleMap["month"];
          var day = scheduleMap["day"];
          var hour = scheduleMap["hour"];
          var minute = scheduleMap["minute"];
          var second = scheduleMap["second"];
          var year = scheduleMap["year"];
          var date = DateTime(year, month, day, hour, minute, second);
          await _notificationService.schedulePlanReminder(date);
        }
      }
    }

    notifyListeners();
  }
}

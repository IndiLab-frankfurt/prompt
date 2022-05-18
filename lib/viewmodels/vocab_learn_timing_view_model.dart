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
        DateTime(dt.year, dt.month, dt.day, newTime.hour, newTime.minute, 0);
    await _notificationService.scheduleDailyReminder(
        newDate, NotificationService.ID_DAILY);

    // in order to reschedule the plan prompt, we need its previous date
    var scheduled = await _notificationService.getPendingNotifications();
    for (var s in scheduled) {
      if (s.id == NotificationService.ID_PLAN_REMINDER) {
        if (s.payload != null) {
          var oldPlanDate = DateTime.parse(s.payload!);
          var newPlanDate = DateTime(oldPlanDate.year, oldPlanDate.month,
              oldPlanDate.day, newDate.hour, newDate.minute, newDate.second);
          await _notificationService.schedulePlanReminder(newPlanDate);
          break;
        }
      }
    }

    notifyListeners();
  }
}

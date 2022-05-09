import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class VocabLearnTimingViewModel extends BaseViewModel {
  final DataService _dataService;

  VocabLearnTimingViewModel(this._dataService);

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
  }
}

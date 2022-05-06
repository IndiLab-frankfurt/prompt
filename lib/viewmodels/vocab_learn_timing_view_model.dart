import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class VocabLearnTimingViewModel extends BaseViewModel {
  final DataService _dataService;

  VocabLearnTimingViewModel(this._dataService);
}

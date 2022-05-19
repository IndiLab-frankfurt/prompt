import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class LearningTricksOverviewViewModel extends BaseViewModel {
  final DataService _dataService;
  final ExperimentService _experimentService;
  LearningTricksOverviewViewModel(this._dataService, this._experimentService);

  List<OpenTasks> openTasks = [];

  bool distributedLearningNotSeen = true;
  bool mentalConstratingNotSeen = true;

  Future<bool> initialize() async {
    var tricksSeen =
        await _dataService.getValuesWithDates("learningTricksSeen");
    distributedLearningNotSeen = _experimentService.learningTrickNotSeenYet(
        tricksSeen, "distributedLearning");
    mentalConstratingNotSeen = _experimentService.learningTrickNotSeenYet(
        tricksSeen, "mentalContrasting");
    return true;
  }
}

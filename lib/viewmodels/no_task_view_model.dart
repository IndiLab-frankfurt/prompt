import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class NoTaskViewModel extends BaseViewModel {
  final ExperimentService _experimentService;
  final DataService _dataService;

  String wurst = "Wurst";

  NoTaskViewModel(this._experimentService, this._dataService);

  //  Future<bool> getNextText() async {
  //   var lastMorningQuestionnaire =

  //   var lastRecallTask = await dataService.getLastRecallTask();
  //   var lastInternalisation = await dataService.getLastInternalisation();
  //   var userData = await dataService.getUserData();
  //   _showNextButton = false;

  //   if (widget.previousRoute == NoTaskSituation.afterInitialization ||
  //       userData.registrationDate.isToday()) {
  //     _textNextTask =
  //         "Morgen geht es richtig los, dann musst du dir zum ersten mal einen Plan merken.";
  //     return true;
  //   }

  //   if (widget.previousRoute == NoTaskSituation.afterFinal) {
  //     _setIsStudyCompleted();
  //     return true;
  //   }

  //   var now = DateTime.now();
  //   if (await _experimentService.isTimeForRecallTask(now)) {
  //     _setIsRecallTask();
  //     return true;
  //   }

  //   if (await _experimentService.isTimeForLexicalDecisionTask(now)) {
  //     _setIsTimeForLDT();
  //     return true;
  //   }

  //   if (await _experimentService.isTimeForInternalisationTask()) {
  //     _setIsTimeForInternalisation();
  //     return true;
  //   }

  //   if (await _experimentService.isTimeForFinalTask()) {
  //     _setIsFinalTask();
  //     return true;
  //   }

  //   // No prior recall task done
  //   if (lastRecallTask == null) {
  //     // Previously done an internalisation
  //     if (lastInternalisation != null) {
  //       // That internalisation was today
  //       if (lastInternalisation.completionDate.isToday()) {
  //         _setNextRecallTimeToday(lastInternalisation);
  //         return true;
  //       }
  //     }
  //   }

  //   // Previously performed a recall task
  //   if (lastRecallTask != null) {
  //     if (!lastRecallTask.completionDate.isToday()) {
  //       // Previously done an internalisation
  //       if (lastInternalisation != null) {
  //         // The last recall task was before the last internalisation
  //         if (lastRecallTask.completionDate
  //             .isBefore(lastInternalisation.completionDate)) {
  //           _setNextRecallTimeToday(lastInternalisation);
  //           return true;
  //         }
  //       }
  //     }
  //   }

  //   // the most unlikely request at the end in order to not do this request
  //   if (await dataService.finalAssessmentCompleted()) {
  //     _setIsStudyCompleted();
  //     return true;
  //   }

  //   _setIsNoTasksForToday();
  //   return true;
  // }
}

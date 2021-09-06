import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/shared/extensions.dart';

class NoTaskViewModel extends BaseViewModel {
  final ExperimentService _experimentService;
  final DataService _dataService;
  final NavigationService _navigationService;

  late int daysActive =
      _dataService.getUserDataCache().registrationDate.daysAgo();

  late double studyProgress = daysActive / 36;

  String message = AppStrings.NoTask_Continue_After_Cabuu;

  NoTaskViewModel(
      this._experimentService, this._dataService, this._navigationService) {
    getNextTask();
  }

  Future<void> getNextTask() async {
    if (await _experimentService.isTimeForMorningAssessment()) {
      this._navigationService.navigateTo(RouteNames.ASSESSMENT_MORNING);
    }

    // if (await _experimentService.isTimeForEveningAssessment()) {
    //   this._navigationService.navigateTo(RouteNames.ASSESSMENT_EVENING);
    // }
  }

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

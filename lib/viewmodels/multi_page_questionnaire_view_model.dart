import 'package:flutter/foundation.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

class MultiPageQuestionnaireViewModel extends MultiPageViewModel {
  final Questionnaire questionnaire;

  final StudyService studyService;

  MultiPageQuestionnaireViewModel(
    DataService dataService, {
    required this.questionnaire,
    required this.studyService,
  }) : super(dataService) {
    pages = questionnaire.questions.toList();
  }

  @override
  bool canMoveBack(ValueKey? currentPageKey) {
    return true;
  }

  @override
  bool canMoveNext(ValueKey? currentPageKey) {
    return true;
  }

  @override
  void submit() async {
    await this.studyService.submitResponses([], "");
    this.studyService.nextScreen("currentScreen");
  }
}

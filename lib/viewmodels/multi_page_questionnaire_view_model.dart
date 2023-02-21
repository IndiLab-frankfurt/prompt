import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

class MultiPageQuestionnaireViewModel extends MultiPageViewModel {
  final Questionnaire questionnaire;

  final StudyService studyService;
  final RewardService rewardService;

  MultiPageQuestionnaireViewModel(
    DataService dataService, {
    required this.rewardService,
    required this.questionnaire,
    required this.studyService,
  }) {
    pages = questionnaire.questions.toList();
  }

  @override
  bool canMoveBack() {
    return true;
  }

  @override
  bool canMoveNext() {
    return true;
  }

  @override
  void submit() async {
    this.setState(ViewState.busy);
    await this.studyService.submitResponses(
        QuestionnaireResponse.fromQuestionnaire(this.questionnaire), "");
    this.studyService.nextScreen();
  }
}

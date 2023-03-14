import 'package:prompt/data/assessments.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/data_privacy_consent_view_model.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';
import 'package:prompt/viewmodels/plan_input_view_model.dart';
import 'package:prompt/viewmodels/plan_timing_view_model.dart';
import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';
import 'package:prompt/viewmodels/questionnaire_video_page_view_model.dart';

enum OnboardingStep {
  welcome,
  data_privacy,
  video_introduction_1,
  rewardScreen1,
  assessment_vocabRoutine,
  instructions_distributedLearning,
  video_distributedLearning,
  assessment_motivation,
  outcome,
  obstacle,
  copingPlan,
  assessment_ToB,
  instructions_implementationIntentions,
  video_planning,
  planCreation,
  planInternalisationEmoji,
  planTiming,
  instructions_cabuu_2,
  video_introduction_2
}

class OnboardingViewModel extends MultiPageViewModel {
  InternalisationViewModel internalisationViewmodelEmoji =
      InternalisationViewModel(
          name: OnboardingStep.planInternalisationEmoji.name,
          condition: InternalisationCondition.emojiBoth);
  late PlanTimingViewModel planTimingViewModel;
  late PlanInputViewModel planInputViewModel = PlanInputViewModel(
      name: OnboardingStep.planCreation.name, onAnswered: onPlanInput);

  PlanInputViewModel planInputViewModelOutcome =
      PlanInputViewModel(name: OnboardingStep.outcome.name);

  PlanInputViewModel planInputViewModelObstacle =
      PlanInputViewModel(name: OnboardingStep.obstacle.name);

  PlanInputViewModel planInputViewModelCoping =
      PlanInputViewModel(name: OnboardingStep.copingPlan.name);

  String _plan = "";
  String get plan => _plan;
  set plan(String plan) {
    this._plan = plan;
    internalisationViewmodelEmoji.plan = plan;
    notifyListeners();
  }

  String cabuuCode = "123";

  void onInternalisationCompleted(String result) {
    notifyListeners();
  }

  void onWaitingInternalisationCompleted(String result) {
    notifyListeners();
  }

  final StudyService _studyService;
  final RewardService _rewardService;
  final DataService _dataService;

  OnboardingViewModel(
      this._studyService, this._dataService, this._rewardService) {
    planInputViewModel.onAnswered = onPlanChanged;
    planTimingViewModel = PlanTimingViewModel(
        name: OnboardingStep.planTiming.name,
        dataService: this._dataService,
        studyService: this._studyService);
    generateScreenOrder();
  }

  void onPlanChanged(QuestionnaireResponse planInput) {
    internalisationViewmodelEmoji.plan =
        "Wenn ich ${planInput.response}, dann lerne ich mit cabuu!";
    this.notifyListeners();
  }

  void generateScreenOrder() {
    var screenOrder = [
      QuestionnairePageViewModel(
          name: OnboardingStep.welcome.name, completed: true),
      DataPrivacyConsentViewModel(name: OnboardingStep.data_privacy.name),
      QuestionnaireVideoPageViewModel(
          name: OnboardingStep.video_introduction_1.name,
          videoUrl: 'assets/videos/onboarding_1.mp4'),
      QuestionnairePageViewModel(
          name: OnboardingStep.rewardScreen1.name, completed: true),
      MultiPageQuestionnaireViewModel(
          name: OnboardingStep.assessment_vocabRoutine.name,
          questionnaire: OB_VocabRoutine(),
          studyService: this._studyService),
      QuestionnairePageViewModel(
          name: OnboardingStep.instructions_distributedLearning.name,
          completed: true),
      QuestionnaireVideoPageViewModel(
          name: OnboardingStep.video_distributedLearning.name,
          videoUrl: 'assets/videos/distributed_practice.mp4'),
      MultiPageQuestionnaireViewModel(
          name: OnboardingStep.assessment_motivation.name,
          questionnaire: OB_Motivation(),
          studyService: this._studyService),
      planInputViewModelOutcome,
      planInputViewModelObstacle,
      planInputViewModelCoping,
      MultiPageQuestionnaireViewModel(
          name: OnboardingStep.assessment_ToB.name,
          questionnaire: OB_ToB(),
          studyService: this._studyService),
      QuestionnairePageViewModel(
          name: OnboardingStep.instructions_implementationIntentions.name,
          completed: true),
      QuestionnaireVideoPageViewModel(
          name: OnboardingStep.video_planning.name,
          videoUrl: 'assets/videos/implementation_intentions.mp4'),
      planInputViewModel,
      internalisationViewmodelEmoji,
      planTimingViewModel,
      QuestionnairePageViewModel(
          name: OnboardingStep.instructions_cabuu_2.name, completed: true),
      QuestionnaireVideoPageViewModel(
          name: OnboardingStep.video_introduction_2.name,
          videoUrl: 'assets/videos/onboarding_2.mp4'),
    ];
    planInputViewModel.onAnswered = onPlanInput;
    pages = screenOrder;
    pages.forEach((element) {
      element.addListener(() {
        notifyListeners();
      });
    });
  }

  void onPlanInput(QuestionnaireResponse planResponse) {
    internalisationViewmodelEmoji.plan = planResponse.response;
  }

  Future<bool> getInitialValues() async {
    var plan = await _dataService.getLastPlan();
    if (plan != null) {
      this.plan = plan;
    }

    var ud = _dataService.getUserDataCache();
    // TODO: Restore after testing
    // initialPage = max(ud.initStep, pages.length - 1);
    initialPage = 0;
    this.setPage(initialPage);
    cabuuCode = ud.cabuuCode.isNotEmpty ? ud.cabuuCode : "HIER CABUU CODE";

    return true;
  }

  List<OnboardingStep> getScreenOrder() {
    return OnboardingStep.values.toList();
  }

  int getNextSubQuestionnairePage(MultiPageQuestionnaireViewModel vm) {
    if (vm.page < vm.pages.length - 1) {
      vm.nextPage();
      return page;
    }
    return page + 1;
  }

  int getPreviousSubQuestionnairePage(MultiPageQuestionnaireViewModel vm) {
    if (vm.page > 0) {
      vm.previousPage();
      return page;
    }
    return page - 1;
  }

  @override
  int getNextPage() {
    var currentPage = pages[page];

    if (currentPage is MultiPageQuestionnaireViewModel) {
      return getNextSubQuestionnairePage(currentPage);
    }

    doStepDependentSubmission();

    return super.getNextPage();
  }

  @override
  int getPreviousPage() {
    var currentPage = pages[page];

    // Multi page questionnaires need special handling because they themselves consist of multiple pages
    if (currentPage is MultiPageQuestionnaireViewModel) {
      return getPreviousSubQuestionnairePage(currentPage);
    }

    return super.getPreviousPage();
  }

  saveInternalisation() {
    var response = QuestionnaireResponse(
        name: InternalisationCondition.emojiIf.name,
        questionnaireName: "internalisation",
        questionText: internalisationViewmodelEmoji.plan,
        response: internalisationViewmodelEmoji.input,
        dateSubmitted: DateTime.now());
    _dataService.saveQuestionnaireResponse(response);
  }

  Future<bool> doStepDependentSubmission() async {
    var stepKey = pages[page];

    switch (stepKey) {
      case OnboardingStep.welcome:
      case OnboardingStep.video_planning:
      case OnboardingStep.video_distributedLearning:
      case OnboardingStep.instructions_cabuu_2:
      case OnboardingStep.instructions_distributedLearning:
      case OnboardingStep.instructions_implementationIntentions:
      case OnboardingStep.rewardScreen1:
        break;
      case OnboardingStep.video_introduction_1:
        if (_rewardService.scoreValue < 5) {
          _rewardService.addPoints(5);
        }
        break;
      case OnboardingStep.assessment_vocabRoutine:
      case OnboardingStep.assessment_ToB:
      case OnboardingStep.assessment_motivation:
      case OnboardingStep.planTiming:
      case OnboardingStep.planCreation:
        break;
      case OnboardingStep.planInternalisationEmoji:
        saveInternalisation();
        if (_rewardService.scoreValue < 10) {
          _rewardService.addPoints(5);
        }
        break;
      case OnboardingStep.outcome:
      case OnboardingStep.obstacle:
      case OnboardingStep.copingPlan:
        break;
    }

    return true;
  }

  @override
  bool canMoveBack() {
    var stepKey = pages[page];

    if (stepKey is MultiPageQuestionnaireViewModel) {
      return stepKey.canMoveBack();
    }

    return true;
  }

  @override
  bool canMoveNext() {
    var stepKey = pages[page];

    if (stepKey is MultiPageQuestionnaireViewModel) {
      return stepKey.canMoveNext();
    }

    return stepKey.completed;
  }

  getResponse() {
    var responses = <QuestionnaireResponse>[];

    for (var page in pages) {
      if (page is MultiPageQuestionnaireViewModel) {
        responses.addAll(
            QuestionnaireResponse.fromQuestionnaire(page.questionnaire));
      } else if (page is QuestionnairePageViewModel) {
        if (page.response != null) responses.add(page.response!);
      }
    }
    // create a response for the onboarding to signal that it is completed
    var onboardingResponse = QuestionnaireResponse(
        name: "onboarding",
        questionnaireName: "onboarding",
        questionText: "",
        response: "completed",
        dateSubmitted: DateTime.now());
    responses.add(onboardingResponse);

    responses.forEach((element) {
      element.questionnaireName = "onboarding";
    });

    return responses;
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);
      await _studyService.submitResponses(getResponse());
      _studyService.nextScreen();
    }
  }
}

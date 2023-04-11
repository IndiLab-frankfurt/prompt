import 'dart:math';

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
  instructions_questionnaires,
  assessment_vocabRoutine,
  instructions_distributedLearning,
  video_distributedLearning,
  assessment_procrastination,
  // outcome,
  // obstacle,
  // copingPlan,
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
      QuestionnairePageViewModel(
          name: OnboardingStep.instructions_questionnaires.name,
          completed: true),
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
          name: OnboardingStep.assessment_ToB.name,
          questionnaire: OB_ToB(),
          studyService: this._studyService),
      MultiPageQuestionnaireViewModel(
          name: OnboardingStep.assessment_procrastination.name,
          questionnaire: OB_Procrastination(),
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

    assert(pages.length == OnboardingStep.values.length);
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
    initialPage = min(ud.onboardingStep, pages.length - 1);
    this.setPage(initialPage);

    cabuuCode = ud.cabuuCode.isNotEmpty ? ud.cabuuCode : "cabuu code missing";

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
    var pageName = pages[page].name;

    if (getPageReward(pageName) > 0) {
      _rewardService.addPoints(5);
      _dataService.saveScore(5);
    }

    // After the plan timing input, there is no more user input, and we can already submit
    if (pageName == OnboardingStep.planTiming.name) {
      submitUserInput();
    }

    _dataService.saveOnboardingStep(page + 1);

    return true;
  }

  void submitUserInput() async {
    var now = DateTime.now();
    var planTimingDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        planTimingViewModel.planTiming.hour,
        planTimingViewModel.planTiming.minute);
    await _studyService.scheduleDailyReminders(planTimingDateTime);
    await _studyService.submitResponses(getResponse());
    await _studyService.onboardingComplete();
  }

  int getPageReward(String name) {
    if (name == OnboardingStep.video_introduction_1.name) {
      return 5;
    }
    return 0;
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
        name: AppScreen.ONBOARDING.name,
        questionnaireName: AppScreen.ONBOARDING.name,
        questionText: "",
        response: "completed",
        dateSubmitted: DateTime.now());
    responses.add(onboardingResponse);

    responses.forEach((element) {
      element.questionnaireName = AppScreen.ONBOARDING.name;
    });

    return responses;
  }

  @override
  void submit() async {
    if (state == ViewState.Idle) {
      setState(ViewState.Busy);
      _dataService.saveOnboardingStep(pages.length - 1);
      _studyService.nextScreen();
    }
  }
}

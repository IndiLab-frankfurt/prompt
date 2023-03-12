import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';
import 'package:prompt/viewmodels/plan_input_view_model.dart';
import 'package:collection/collection.dart';

class PlanPromptViewModel extends MultiPageViewModel {
  String plan = "";
  InternalisationViewModel internalisationViewmodelEmoji =
      InternalisationViewModel(
          name: "Internalisation Emoji",
          condition: InternalisationCondition.emojiBoth);
  PlanInputViewModel planInputViewModel =
      PlanInputViewModel(name: "Plan Input");

  final StudyService studyService;
  final DataService dataService;

  final List<QuestionnaireResponse> responses = [];

  PlanPromptViewModel({
    required this.studyService,
    required this.dataService,
  }) {
    planInputViewModel.onAnswered = onPlanChanged;
    internalisationViewmodelEmoji.onAnswered = onEmojisCompleted;
    pages = [planInputViewModel, internalisationViewmodelEmoji];
  }

  void onPlanChanged(QuestionnaireResponse planResponse) {
    internalisationViewmodelEmoji.plan = planResponse.response;
    updateRespones(planResponse);
    this.notifyListeners();
  }

  void onEmojisCompleted(QuestionnaireResponse planResponse) {
    updateRespones(planResponse);
    this.notifyListeners();
  }

  void updateRespones(QuestionnaireResponse response) {
    // if a response with the same name already exists, replace it
    var existing =
        responses.firstWhereOrNull((element) => element.name == response.name);
    if (existing != null) {
      responses.remove(existing);
    }
    responses.add(response);
  }

  @override
  bool canMoveBack() {
    return true;
  }

  @override
  bool canMoveNext() {
    return pages[page].completed;
  }

  List<QuestionnaireResponse> buildResponses() {
    return [];
  }

  @override
  void submit() async {
    this.setState(ViewState.busy);
    await this.studyService.submitResponses(responses);
    this.studyService.nextScreen();
  }
}

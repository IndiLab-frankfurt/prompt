import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';
import 'package:prompt/viewmodels/plan_input_view_model.dart';

class PlanPromptViewModel extends MultiPageViewModel {
  String plan = "";
  InternalisationViewModel internalisationViewmodelEmoji =
      InternalisationViewModel(condition: InternalisationCondition.emojiBoth);
  PlanInputViewModel planInputViewModel = PlanInputViewModel();

  final StudyService studyService;
  final DataService dataService;

  PlanPromptViewModel({
    required this.studyService,
    required this.dataService,
  }) {
    planInputViewModel.addListener(() {
      plan = planInputViewModel.plan;
      internalisationViewmodelEmoji.plan = plan;
    });
    pages = [planInputViewModel, internalisationViewmodelEmoji];
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
    await this.studyService.submitResponses(buildResponses());
    this.studyService.nextScreen();
    this.setState(ViewState.idle);
  }
}

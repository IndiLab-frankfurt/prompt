import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/viewmodels/plan_view_model.dart';

class PlanEditViewModel extends BaseViewModel {
  final DataService _dataService;
  final ExperimentService _experimentService;
  PlanViewModel planViewModel = PlanViewModel();

  PlanEditViewModel(this._dataService, this._experimentService);

  Future<bool> initialize() async {
    var plan = await _dataService.getLastPlan();
    if (plan != null) {
      planViewModel.plan = plan.plan;
    }
    return true;
  }

  Future submit() async {
    this.setState(ViewState.busy);
    Future.wait([
      _dataService.savePlan(planViewModel.plan),
      _dataService.saveSimpleValueWithTimestamp(
          planViewModel.plan, "planChanges")
    ]).then((_) {
      _experimentService.nextScreen(RouteNames.EDIT_PLAN);
    }).then((value) => this.setState(ViewState.idle));
  }
}

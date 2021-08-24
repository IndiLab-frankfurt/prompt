import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';

class DailyInternalisationViewModel extends BaseViewModel {
  InternalisationViewModel internalisation = InternalisationViewModel();

  final ExperimentService experimentService;
  final DataService dataService;

  DailyInternalisationViewModel(
    this.experimentService,
    this.dataService,
  );

  submit() async {
    experimentService.nextScreen(RouteNames.DAILY_INTERNALISATION);
  }
}

import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';

class DailyInternalisationViewModel extends BaseViewModel {
  InternalisationViewModel internalisation = InternalisationViewModel();

  final StudyService experimentService;
  final DataService dataService;

  DailyInternalisationViewModel(
    this.experimentService,
    this.dataService,
  );

  submit() async {
    experimentService.nextScreen();
  }
}

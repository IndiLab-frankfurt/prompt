import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class NoTaskViewModel extends BaseViewModel {
  final ExperimentService _experimentService;
  final DataService _dataService;

  NoTaskViewModel(this._experimentService, this._dataService);
}

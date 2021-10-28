import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class ChangeMascotViewModel extends BaseViewModel {
  final RewardService _rewardService;
  final DataService _dataService;

  ChangeMascotViewModel(this._rewardService, this._dataService);

  late String _selectedMascot = _rewardService.selectedMascot;
  String get selectedMascot => _selectedMascot;
  set selectedMascot(String selected) {
    this._selectedMascot = selected;
    _dataService.setSelectedMascot(selected);
    _rewardService.changeMascot(selected);
    notifyListeners();
  }
}

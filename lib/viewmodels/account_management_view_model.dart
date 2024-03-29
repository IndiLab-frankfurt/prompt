import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class AccountManagementViewModel extends BaseViewModel {
  DataService dataService;
  NavigationService navigationService;

  late String username;
  late String cabuuCode;

  AccountManagementViewModel(
      {required this.dataService, required this.navigationService}) {
    username = dataService.getUserDataCache().username;
    cabuuCode = dataService.getUserDataCache().cabuuCode;
  }

  Future<void> logout() async {
    this.setState(ViewState.Busy);
    await dataService.logout();
    navigationService.navigateAndRemove(AppScreen.LOGIN);
  }

  Future<bool> deleteAccount(String password) async {
    if (password.isEmpty) {
      return false;
    }
    var response = await dataService.signInUser(username, password);
    if (response == null) {
      return false;
    }
    this.setState(ViewState.Busy);
    await dataService.deleteAccount();
    navigationService.navigateAndRemove(AppScreen.LOGIN);
    return true;
  }
}

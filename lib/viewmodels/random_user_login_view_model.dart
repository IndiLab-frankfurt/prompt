import 'package:prompt/locator.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class RandomUserLoginViewModel extends BaseViewModel {
  UserService _userService;
  NavigationService _navigationService;

  RandomUserLoginViewModel(this._userService, this._navigationService) {
    // loginAsRandomUser();
  }

  Future<bool> loginAsRandomUser() async {
    var signedIn = _userService.isSignedIn();
    if (signedIn) {
      _navigationService.navigateTo(RouteNames.NO_TASKS);
      return true;
    }

    try {
      await _userService.saveRandomUser();
      await locator<RewardService>().initialize();
      locator<DataService>().setRegistrationDate(DateTime.now());
      _navigationService.navigateTo(RouteNames.SESSION_ZERO);
      return true;
    } catch (e) {
      print("Error logging in as random user: $e");
      return false;
    }
  }
}

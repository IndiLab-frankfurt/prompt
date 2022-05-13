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

  RandomUserLoginViewModel(this._userService, this._navigationService) {}

  Future<bool> loginAsRandomUser() async {
    var signedIn = _userService.isSignedIn();
    if (signedIn) {
      print("Already signed in");
      await _navigationService.navigateTo(RouteNames.NO_TASKS);
      return true;
    }
    print("Not yet signed in, creating new user");
    try {
      await _userService.saveRandomUser();
      await locator<RewardService>().initialize();
      await locator<DataService>().setRegistrationDate(DateTime.now());
      await _navigationService.navigateTo(RouteNames.SESSION_ZERO);
      return true;
    } catch (e) {
      print("Error logging in as random user: $e");
      return false;
    }
  }
}

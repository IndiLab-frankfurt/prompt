import 'package:email_validator/email_validator.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/api_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/services/data_service.dart';

class LoginViewModel extends BaseViewModel {
  String _email = "";
  String get email => _email;

  UserService _userService;
  NavigationService _navigationService;

  String defaultPassword = "Hasselhoernchen";

  LoginViewModel(this._userService, this._navigationService) {
    var username = this._userService.getUsername();
    if (username.isNotEmpty) {
      var indexOfSplit = username.indexOf("@");
      if (indexOfSplit >= 0) {
        _email = username.substring(0, indexOfSplit);
      }
    }
  }

  Future<String> signIn(String username, String password) async {
    setState(ViewState.busy);
    var signin = await _userService.signInUser(username, password);
    if (signin == null) {
      setState(ViewState.idle);
      return RegistrationCodes.USER_NOT_FOUND;
    }

    // await locator<RewardService>().initialize();
    // await locator<NotificationService>().clearPendingNotifications();
    // locator<ExperimentService>().schedulePrompts(signin.group);

    setState(ViewState.idle);
    return RegistrationCodes.SUCCESS;
  }

  getDefaultPassword(String userid) {
    return "hasselhoernchen!$userid";
  }

  submit() async {
    // locator<DataService>().setRegistrationDate(DateTime.now());
    _navigationService.navigateTo(RouteNames.SESSION_ZERO);
  }

  validateEmail(String userid) {
    return EmailValidator.validate(userid);
  }

  validateUserId(String value) {
    return true;
  }
}

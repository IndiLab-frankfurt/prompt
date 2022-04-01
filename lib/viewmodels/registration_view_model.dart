import 'package:email_validator/email_validator.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/services/data_service.dart';

class RegistrationViewModel extends BaseViewModel {
  String _email = "";
  String get email => _email;

  bool useRandomUserSignIn = true;

  UserService _userService;
  NavigationService _navigationService;

  RegistrationViewModel(this._userService, this._navigationService);

  Future<bool> loginAsRandomUser() async {
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

  Future<bool> isEmailAlreadyRegistered(String email) async {
    return await _userService.isNameAvailable(email);
  }

  Future<String> register(String input, String password) async {
    var email = input;

    setState(ViewState.busy);
    var signin = await _userService.registerUser(email, password);
    if (signin == null) {
      setState(ViewState.idle);
      return RegistrationCodes.USER_NOT_FOUND;
    } else {
      await locator<RewardService>().initialize();
      await locator<NotificationService>().clearPendingNotifications();

      setState(ViewState.idle);
      return RegistrationCodes.SUCCESS;
    }
  }

  submit() async {
    locator<DataService>().setRegistrationDate(DateTime.now());
    _navigationService.navigateTo(RouteNames.SESSION_ZERO);
  }

  progressWithoutUsername() async {
    await _userService.saveRandomUser();
  }

  validateEmail(String userid) {
    return EmailValidator.validate(userid);
  }

  validatePassword(String value) {
    return value.length > 5;
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';

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
    setState(ViewState.Busy);
    var userData = await _userService.signInUser(username, password);
    if (userData == null) {
      setState(ViewState.Idle);
      return RegistrationCodes.USER_NOT_FOUND;
    }

    setState(ViewState.Idle);
    if (userData.onboardingStep >= OnboardingStep.values.length - 2) {
      _navigationService.navigateTo(AppScreen.MAINSCREEN);
    } else {
      _navigationService.navigateTo(AppScreen.ONBOARDING);
    }
    return RegistrationCodes.SUCCESS;
  }

  getDefaultPassword(String userid) {
    return "hasselhoernchen!$userid";
  }

  startOnboarding() async {
    _navigationService.navigateTo(AppScreen.ONBOARDING);
  }

  validateEmail(String userid) {
    return EmailValidator.validate(userid);
  }

  validateUserId(String value) {
    return true;
  }
}

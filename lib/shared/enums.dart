enum ViewState { idle, busy }

class SettingsKeys {
  static const String userId = "userid";
  static const String email = "email";
  static const String timerDurationInSeconds = "timerDurationInSeconds";
  static const String initSessionStep = "initSessionStep";
  static const String backGroundImage = "backgroundImage";
  static const String backgroundColors = "backgroundColors";
}

enum AppStartupMode {
  normal,
  signin,
  firstLaunch,
  noTasks,
}

class RegistrationCodes {
  static const SUCCESS = "SUCCESS";
  static const WEAK_PASSWORD = "ERROR_WEAK_PASSWORD";
  static const INVALID_CREDENTIAL = "ERROR_INVALID_CREDENTIAL";
  static const EMAIL_ALREADY_IN_USE = "ERROR_EMAIL_ALREADY_IN_USE";
  static const USER_NOT_FOUND = "user-not-found";
}

enum AssessmentTypes { srl, motivation }

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

enum AssessmentTypes {
  srl,
  didLearnToday,
  didLearnWhen,
  motivation,
  itLiteracy,
  distributedPractice,
  learningFrequencyDuration,
  learningExpectations,
  selfEfficacy,
  didLearnYesterday,
  morning,
  planCommitment,
  afterTest,
  afterTest_2,
  afterTest_failure,
  afterTest_success,
  evening_alternative,
  evening_1,
  evening_1_yesterday,
  evening_2,
  evening_2_yesterday,
  evening_3,
  evening_3_yesterday,
  morning_intention,
  morning_with_intention,
  morning_without_intention,
  finalSession_1,
  finalSession_2,
  finalSession_3,
  finalSession_4,
}

enum InternalisationCondition {
  waiting,
  emojiIf,
  emojiThen,
}

const String EVENING_ASSESSMENT = "eveningAssessment";
const String MORNING_ASSESSMENT = "morningAssessment";
const String FINAL_ASSESSMENT = "finalAssessment";
const String SESSION_ZERO = "sessionZero";

enum ViewState { Idle, Busy }

enum AppStartupMode { normal, signin, firstLaunch, noTasks, onboarding }

class RegistrationCodes {
  static const SUCCESS = "SUCCESS";
  static const WEAK_PASSWORD = "ERROR_WEAK_PASSWORD";
  static const INVALID_CREDENTIAL = "ERROR_INVALID_CREDENTIAL";
  static const EMAIL_ALREADY_IN_USE = "ERROR_EMAIL_ALREADY_IN_USE";
  static const USER_NOT_FOUND = "user-not-found";
}

class AssessmentTypes {
  static const srl = 'srl';
  static const didLearnToday = 'didLearnToday';
  static const didLearnWhen = 'didLearnWhen';
  static const motivation = 'motivation';
  static const itLiteracy = 'itLiteracy';
  static const distributedPractice = 'distributedPractice';
  static const learningFrequencyDuration = 'learningFrequencyDuration';
  static const learningExpectations = 'learningExpectations';
  static const selfEfficacy = 'selfEfficacy';
  static const didLearnYesterday = 'didLearnYesterday';
  static const morning = 'morning';
  static const planCommitment = 'planCommitment';
  static const afterTest = 'afterTest';
  static const afterTest_2 = 'afterTest_2';
  static const afterTest_failure = 'afterTest_failure';
  static const afterTest_success = 'afterTest_success';
  static const evening_alternative = 'evening_alternative';
  static const evening_1 = 'evening_1';
  static const evening_1_yesterday = 'evening_1_yesterday';
  static const evening_2 = 'evening_2';
  static const evening_2_yesterday = 'evening_2_yesterday';
  static const evening_3 = 'evening_3';
  static const evening_3_yesterday = 'evening_3_yesterday';
  static const morning_intention = 'morning_intention';
  static const morning_with_intention = 'morning_with_intention';
  static const morning_without_intention = 'morning_without_intention';
  static const finalSession_1 = 'finalSession_1';
  static const finalSession_2 = 'finalSession_2';
  static const finalSession_3 = 'finalSession_3';
  static const finalSession_4 = 'finalSession_4';
  static const plan = "plan";
  static const vocabValue = "vocabValue";
}

enum InternalisationCondition { waiting, emojiIf, emojiThen, emojiBoth }

enum AppScreen {
  MAINSCREEN("/main"),
  LOGIN("/login"),
  ONBOARDING("/onboarding"),
  ABOUTPROMPT("/aboutprompt"),
  AA_DIDYOULEARN("aa/didyoulearn"),
  AA_NEXTSTUDYSESSION("aa/nextstudysession"),
  AA_PREVIOUSSTUDYSESSION("aa/previousstudysession"),
  AA_PROCRAST("aa/procrast"),
  REMINDERTESTTOMORROW("/remindertesttomorrow"),
  WEEKLYQUESTIONS("/weeklyquestions"),
  REMEMBERTOLEARN("/remembertolearn"),
  DIDYOUTEST("/didyoutest"),
  REMINDERTESTTODAY("/remindertesttoday"),
  REMINDERNEXTLIST("/remindernextlist"),
  PLANPROMPT("/planprompt"),
  FINALQUESTIONNAIRE("/finalquestionnaire"),
  QUESTIONNAIRE("/aa"),
  SCREENSELECT("/screenselect"),
  REWARDSELECTION("/rewardselection"),
  DATAPRIVACY("/dataprivacy"),
  PLANTIMINGCHANGE("/plantimingchange"),
  FORGOTPASSWORD("/forgotpassword"),
  VOCABTESTTODAY("/vocabtoday"),
  THEMEPREVIEW("/themepreview"),
  ACCOUNTMANAGEMENT("/accountmanagement"),
  STUDYFINISHED("/studyfinished"),
  USERSETTINGS("/usersettings"),
  LEARNINGPLANCABUU("/learningplancabuu");

  const AppScreen(this.routeName);
  final String routeName;
}

enum SettingsKeys {
  username,
  email,
  password,
  accessToken,
  refreshToken,
  backGroundImage,
  backgroundColors,
  fcmToken,
  apiBaseUrl,
}

const String EVENING_ASSESSMENT = "eveningAssessment";
const String MORNING_ASSESSMENT = "morningAssessment";
const String FINAL_ASSESSMENT = "finalAssessment";
const String SESSION_ZERO = "sessionZero";

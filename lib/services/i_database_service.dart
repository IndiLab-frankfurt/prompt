import 'package:firebase_auth/firebase_auth.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/authentication_response.dart';
import 'package:prompt/models/internalisation.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/models/user_data.dart';

abstract class IDatabaseService {
  Stream<User?>? getCurrentUser();

  Future<UserData?> registerUser(
      String userId, String password, int internalisationCondition);

  updateUserData(UserData userData);

  saveScrambleCorrections(dynamic corrections);

  Future<UserData?> getUserData();

  Future<AuthenticationResponse?> signInUser(String userId, String password);

  Future<String?> getLastPlan();

  Future<void> saveScore(String userid, int score);

  Future<void> logEvent(Map<String, String> data);

  Future<void> saveInitSessionStepCompleted(String userid, int step);

  Future<void> setStreakDays(String username, int value);

  Future saveDaysAcive(String username, int daysActive);

  Future setRegistrationDate(String username, String dateString);

  Future<bool> saveQuestionnaireResponses(List<QuestionnaireResponse> response);

  Future saveInternalisation(Internalisation internalisation, String email);

  Future saveUsageStats(Map<String, dynamic> usageInfo, String userid);

  Future<QuestionnaireResponse?> getLastQuestionnaireResponse(
      String questionName);

  Future<List<AssessmentResult>> getAssessmentResults(String userid);

  Future saveUserDataProperty(String key, dynamic value);

  Future saveBoosterPromptReadTimes(Map<String, dynamic> map);
}

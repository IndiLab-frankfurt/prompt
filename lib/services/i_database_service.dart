import 'package:firebase_auth/firebase_auth.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/internalisation.dart';
import 'package:prompt/models/plan.dart';
import 'package:prompt/models/user_data.dart';

abstract class IDatabaseService {
  Stream<User?>? getCurrentUser();

  Future<bool?> isNameAvailable(String userId);

  Future<UserData?> registerUser(
      String userId, String password, int internalisationCondition);

  insertUserData(UserData userData);

  saveScrambleCorrections(dynamic corrections);

  Future<UserData?> getUserData(String email);

  Future<User?> signInUser(String userId, String password);

  saveAssessment(AssessmentResult assessment, String userid);

  savePlan(Plan plan, String userid);

  Future<Plan?> getLastPlan(String userid);

  Future<void> saveScore(String userid, int score);

  logEvent(String userid, dynamic data);

  Future<void> saveInitSessionStepCompleted(String userid, int step);

  Future<void> setStreakDays(String username, int value);

  Future saveDaysAcive(String username, int daysActive);

  Future setRegistrationDate(String username, String dateString);

  Future saveVocabValue(Plan plan, String userid);

  Future saveInternalisation(Internalisation internalisation, String email);

  Future saveUsageStats(Map<String, dynamic> usageInfo, String userid);

  Future<AssessmentResult?> getLastAssessmentResult(String userid);

  Future<List<AssessmentResult>> getAssessmentResults(String userid);

  Future<Map<String, dynamic>?> getInitialData(String userid);

  Future<AssessmentResult?> getLastAssessmentResultFor(
      String userid, String assessmentName);

  Future saveUserDataProperty(String username, String key, dynamic value);

  Future saveBoosterPromptReadTimes(Map<String, dynamic> map);
}

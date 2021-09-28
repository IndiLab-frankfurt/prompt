import 'package:firebase_auth/firebase_auth.dart';
import 'package:prompt/models/assessment_result.dart';
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

  Future<AssessmentResult?> getLastAssessmentResult(String userid);

  Future<List<AssessmentResult>> getAssessmentResults(String userid);

  Future<AssessmentResult?> getLastAssessmentResultFor(
      String userid, String assessmentName);

  Future saveUserDataProperty(String username, String key, dynamic value);
}

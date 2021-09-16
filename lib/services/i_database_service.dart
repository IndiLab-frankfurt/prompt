import 'package:firebase_auth/firebase_auth.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/user_data.dart';

abstract class IDatabaseService {
  void handleError(Object? e, {String data = ""}) {}

  void handleTimeout(String function);

  Stream<User?>? getCurrentUser();

  Future<bool?> isNameAvailable(String userId);

  Future<UserData?> registerUser(
      String userId, String password, int internalisationCondition) async {}

  insertUserData(UserData userData) async {}

  saveScrambleCorrections(dynamic corrections) async {}

  Future<UserData?> getUserData(String email) async {}

  Future<User?> signInUser(String userId, String password) async {}

  saveAssessment(AssessmentResult assessment, String userid);

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

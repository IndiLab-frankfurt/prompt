import 'package:prompt/models/internalisation.dart';
import 'package:prompt/models/plan.dart';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prompt/services/i_database_service.dart';

class MockFirebaseService implements IDatabaseService {
  @override
  Stream<User?>? getCurrentUser() {
    return Stream.value(null);
  }

  @override
  Future<UserData?> getUserData(String email) {
    throw UnimplementedError();
  }

  @override
  insertUserData(UserData userData) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isNameAvailable(String userId) {
    throw UnimplementedError();
  }

  @override
  logEvent(String userid, data) {
    throw UnimplementedError();
  }

  @override
  Future<UserData?> registerUser(
      String userId, String password, int internalisationCondition) {
    throw UnimplementedError();
  }

  @override
  saveAssessment(AssessmentResult assessment, String userid) {
    throw UnimplementedError();
  }

  @override
  Future saveDaysAcive(String username, int daysActive) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveInitSessionStepCompleted(String userid, int step) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveScore(String userid, int score) {
    throw UnimplementedError();
  }

  @override
  saveScrambleCorrections(corrections) {
    throw UnimplementedError();
  }

  @override
  Future setRegistrationDate(String username, String dateString) {
    throw UnimplementedError();
  }

  @override
  Future<void> setStreakDays(String username, int value) {
    throw UnimplementedError();
  }

  @override
  Future<User?> signInUser(String userId, String password) {
    throw UnimplementedError();
  }

  @override
  Future<AssessmentResult?> getLastAssessmentResult(String userid) {
    throw UnimplementedError();
  }

  @override
  Future saveUserDataProperty(String username, String key, value) {
    throw UnimplementedError();
  }

  @override
  Future<AssessmentResult?> getLastAssessmentResultFor(
      String userid, String assessmentName) {
    throw UnimplementedError();
  }

  @override
  Future<List<AssessmentResult>> getAssessmentResults(String userid) {
    throw UnimplementedError();
  }

  @override
  savePlan(Plan plan, String userid) {
    throw UnimplementedError();
  }

  @override
  Future<Plan?> getLastPlan(String userid) {
    throw UnimplementedError();
  }

  @override
  Future saveVocabValue(Plan plan, String userid) {
    throw UnimplementedError();
  }

  @override
  Future saveInternalisation(Internalisation internalisation, String email) {
    throw UnimplementedError();
  }

  @override
  Future saveUsageStats(Map<String, dynamic> usageInfo, String userid) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> getInitialData(String userid) {
    // TODO: implement getInitialData
    throw UnimplementedError();
  }
}

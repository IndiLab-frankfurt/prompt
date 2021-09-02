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
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  void handleError(Object? e, {String data = ""}) {
    // TODO: implement handleError
  }

  @override
  void handleTimeout(String function) {
    // TODO: implement handleTimeout
  }

  @override
  insertUserData(UserData userData) {
    // TODO: implement insertUserData
    throw UnimplementedError();
  }

  @override
  Future<bool?> isNameAvailable(String userId) {
    // TODO: implement isNameAvailable
    throw UnimplementedError();
  }

  @override
  logEvent(String userid, data) {
    // TODO: implement logEvent
    throw UnimplementedError();
  }

  @override
  Future<UserData?> registerUser(
      String userId, String password, int internalisationCondition) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  saveAssessment(AssessmentResult assessment, String userid) {
    // TODO: implement saveAssessment
    throw UnimplementedError();
  }

  @override
  Future saveDaysAcive(String username, int daysActive) {
    // TODO: implement saveDaysAcive
    throw UnimplementedError();
  }

  @override
  Future<void> saveInitSessionStepCompleted(String userid, int step) {
    // TODO: implement saveInitSessionStepCompleted
    throw UnimplementedError();
  }

  @override
  Future<void> saveScore(String userid, int score) {
    // TODO: implement saveScore
    throw UnimplementedError();
  }

  @override
  saveScrambleCorrections(corrections) {
    // TODO: implement saveScrambleCorrections
    throw UnimplementedError();
  }

  @override
  Future setRegistrationDate(String username, String dateString) {
    // TODO: implement setRegistrationDate
    throw UnimplementedError();
  }

  @override
  Future<void> setStreakDays(String username, int value) {
    // TODO: implement setStreakDays
    throw UnimplementedError();
  }

  @override
  Future<User?> signInUser(String userId, String password) {
    // TODO: implement signInUser
    throw UnimplementedError();
  }

  @override
  Future<AssessmentResult?> getLastAssessmentResult(String userid) {
    // TODO: implement getLastAssessmentResult
    throw UnimplementedError();
  }
}

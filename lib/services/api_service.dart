import 'dart:convert';

import 'package:prompt/models/user_data.dart';
import 'package:prompt/models/plan.dart';
import 'package:prompt/models/internalisation.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prompt/services/i_database_service.dart';
import 'package:http/http.dart' as http;

class ApiService implements IDatabaseService {
  static String endpoint = "127.0.0.1:8000/api";

  Future<void> getToken() async {
    var userid = "daniel";
    var password = "muhmuh";
    var url = Uri.parse("http://$endpoint/api/token/");
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: ({"username": userid, "password": password}));
    if (response.statusCode == 200) {
      var data = response.body;
      var accessToken = jsonDecode(data)["access"];
      print(accessToken);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Future<List<AssessmentResult>> getAssessmentResults(String userid) {
    // TODO: implement getAssessmentResults
    throw UnimplementedError();
  }

  @override
  Stream<User?>? getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> getInitialData(String userid) {
    // TODO: implement getInitialData
    throw UnimplementedError();
  }

  @override
  Future<AssessmentResult?> getLastAssessmentResult(String userid) {
    // TODO: implement getLastAssessmentResult
    throw UnimplementedError();
  }

  @override
  Future<AssessmentResult?> getLastAssessmentResultFor(
      String userid, String assessmentName) {
    // TODO: implement getLastAssessmentResultFor
    throw UnimplementedError();
  }

  @override
  Future<Plan?> getLastPlan(String userid) {
    // TODO: implement getLastPlan
    throw UnimplementedError();
  }

  @override
  Future<UserData?> getUserData(String email) {
    // TODO: implement getUserData
    throw UnimplementedError();
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
  Future saveBoosterPromptReadTimes(Map<String, dynamic> map) {
    // TODO: implement saveBoosterPromptReadTimes
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
  Future saveInternalisation(Internalisation internalisation, String email) {
    // TODO: implement saveInternalisation
    throw UnimplementedError();
  }

  @override
  savePlan(Plan plan, String userid) {
    // TODO: implement savePlan
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
  Future saveUsageStats(Map<String, dynamic> usageInfo, String userid) {
    // TODO: implement saveUsageStats
    throw UnimplementedError();
  }

  @override
  Future saveUserDataProperty(String username, String key, value) {
    // TODO: implement saveUserDataProperty
    throw UnimplementedError();
  }

  @override
  Future saveVocabValue(Plan plan, String userid) {
    // TODO: implement saveVocabValue
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
}

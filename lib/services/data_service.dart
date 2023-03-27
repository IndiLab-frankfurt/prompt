import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/models/assessment_item.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/authentication_response.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/models/user_data.dart';
import 'package:collection/collection.dart';
import 'package:prompt/services/api_service.dart';
import 'package:prompt/services/base_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/shared/enums.dart';

class DataService implements BaseService {
  final ApiService _apiService;
  final SettingsService _settingsService;

  UserData? _userDataCache;
  AssessmentResult? _lastAssessmentResultCache;
  List<AssessmentResult>? _assessmentResultsCache;

  DataService(this._apiService, this._settingsService);

  sendLogs(List<dynamic> data) async {
    _apiService.logEvents(data);
  }

  setUserDataCache(UserData ud) async {
    _userDataCache = ud;
  }

  Future<UserData?> getUserData() async {
    if (_userDataCache == null) {
      _userDataCache = (await _apiService.getUserData());
    }

    return _userDataCache;
  }

  UserData getUserDataCache() {
    return _userDataCache!;
  }

  saveScore(int score) async {
    var userData = getUserDataCache();
    userData.score = score;
    await _apiService.saveUserDataProperty("score", score);
  }

  saveOnboardingStep(int step) async {
    var userData = getUserDataCache();
    userData.onboardingStep = step;
    await _apiService.saveUserDataProperty("onboarding_step", step);
  }

  Future<int> getDaysActive() async {
    var userData = await getUserData();
    if (userData == null) return 0;
    return userData.daysActive;
  }

  Future<int> getScore() async {
    return getUserData().then((userData) {
      if (userData == null)
        return 0;
      else
        return userData.score;
    });
  }

  AssessmentResult? getLastAssessmentResultForCached(String assessmentName) {
    if (_assessmentResultsCache == null) {
      _assessmentResultsCache = [];
    } else {
      _assessmentResultsCache!.sortBy((element) => element.submissionDate);
    }
    return _assessmentResultsCache!
        .lastWhereOrNull((element) => element.assessmentType == assessmentName);
  }

  List<AssessmentResult>? getAssessmentResultsCached() {
    return _assessmentResultsCache;
  }

  AssessmentResult? getLastAssessmentResultCached() {
    return _lastAssessmentResultCache;
  }

  Future<QuestionnaireResponse?> getLatestQuestionnaireResponse(
      String questionnaireName) async {
    return await _apiService.getLastQuestionnaireResponse(questionnaireName);
  }

  saveDaysActive(int daysActive) async {
    throw Exception("Not implemented");
  }

  Future<UserData?> saveUserDataProperty(
      String propertyname, dynamic value) async {
    var resonse = await _apiService.saveUserDataProperty(propertyname, value);
    if (resonse is Map<String, dynamic>) {
      _userDataCache = UserData.fromJson(resonse);
      return _userDataCache;
    }
    return null;
  }

  Future<dynamic> saveQuestionnaireResponse(
      QuestionnaireResponse response) async {
    return await _apiService.saveQuestionnaireResponses([response]);
  }

  Future<Map<String, dynamic>> saveQuestionnaireResponses(
      List<QuestionnaireResponse> responses) async {
    var responseData = await _apiService.saveQuestionnaireResponses(responses);
    var userDataResponse = responseData["user_profile"];
    if (userDataResponse != null) {
      _userDataCache = UserData.fromJson(userDataResponse);
    }
    return responseData;
  }

  Future<String?> getLastPlan() async {
    return await _apiService.getLastPlan();
  }

  Future<int> getStreakDays() async {
    var userData = await getUserData();
    if (userData == null) return 0;
    return userData.streakDays;
  }

  Future<List<Color>?> getBackgroundGradientColors() async {
    var colorString =
        await _settingsService.getSetting(SettingsKeys.backgroundColors);
    if (colorString != null) {
      List<String> colorStringList = colorString.split(",");
      var list =
          colorStringList.map((e) => Color(int.parse(e, radix: 16))).toList();

      return list;
    } else {
      return null;
    }
  }

  Future<void> setBackgroundImage(String imagePath) async {
    await _settingsService.setSetting(SettingsKeys.backGroundImage, imagePath);
  }

  Future<String?> getBackgroundImagePath() async {
    return await _settingsService.getSetting(SettingsKeys.backGroundImage);
  }

  Future saveBackgroundGradientColors(List<Color> colors) async {
    var colorString = colors
        .map((e) => e.toString().split('(0x')[1].split(')')[0])
        .toList()
        .join(",");
    _settingsService.setSetting(SettingsKeys.backgroundColors, colorString);
  }

  Future<void> setStreakDays(int value) async {
    throw Exception("Not implemented");
  }

  Future<AppScreen> getNextState(String currentScreen) async {
    var response = await _apiService.getNextState(currentScreen);

    return AppScreen.values.byName(response.toUpperCase());
  }

  Future<bool> deleteAccount() async {
    await _apiService.deleteAccount();
    this.logout();
    return true;
  }

  getAssessment(String name) async {
    String data =
        await rootBundle.loadString("assets/assessments/assessment_$name.json");
    var json = jsonDecode(data);

    var ass = Assessment();
    ass.name = json["id"];
    ass.title = json["title"];
    ass.items = [];
    for (var question in json["questions"]) {
      ass.items.add(AssessmentItem(question["questionText"],
          Map<String, String>.from(question["labels"]), question["id"]));
    }

    return ass;
  }

  Future<AuthenticationResponse?> signInUser(
      String username, String password) async {
    return await _apiService.signInUser(username, password);
  }

  @override
  Future<bool> initialize() async {
    return true;
  }

  logout() async {
    await this._settingsService.deleteSetting(SettingsKeys.email);
    await this._settingsService.deleteSetting(SettingsKeys.password);
  }
}

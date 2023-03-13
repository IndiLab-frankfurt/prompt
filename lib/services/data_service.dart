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
  final ApiService _databaseService;
  final SettingsService _settingsService;

  UserData? _userDataCache;
  AssessmentResult? _lastAssessmentResultCache;
  List<AssessmentResult>? _assessmentResultsCache;

  DataService(this._databaseService, this._settingsService);

  logData(Map<String, String> data) async {
    _databaseService.logEvent(data);
  }

  setUserDataCache(UserData ud) async {
    _userDataCache = ud;
  }

  Future<UserData?> getUserData() async {
    if (_userDataCache == null) {
      _userDataCache = (await _databaseService.getUserData());
    }

    return _userDataCache;
  }

  UserData getUserDataCache() {
    return _userDataCache!;
  }

  saveScore(int score) async {
    var userData = getUserDataCache();
    userData.score = score;
    await _databaseService.updateUserData(userData);
  }

  saveSessionZeroStep(int step) async {
    var userData = getUserDataCache();
    userData.onboardingStep = step;
    await _databaseService.saveUserDataProperty("init_step", step);
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
    return await _databaseService
        .getLastQuestionnaireResponse(questionnaireName);
  }

  saveDaysActive(int daysActive) async {
    throw Exception("Not implemented");
  }

  saveUserDataProperty(String propertyname, dynamic value) async {
    await _databaseService.saveUserDataProperty(propertyname, value);
    _userDataCache = await _databaseService.getUserData();
  }

  Future<dynamic> saveQuestionnaireResponse(
      QuestionnaireResponse response) async {
    return await _databaseService.saveQuestionnaireResponses([response]);
  }

  Future<Map<String, dynamic>> saveQuestionnaireResponses(
      List<QuestionnaireResponse> responses) async {
    var responseData =
        await _databaseService.saveQuestionnaireResponses(responses);
    var userDataResponse = responseData["user_profile"];
    if (userDataResponse != null) {
      _userDataCache = UserData.fromJson(userDataResponse);
    }
    return responseData;
  }

  Future<String?> getLastPlan() async {
    return await _databaseService.getLastPlan();
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
    var response = await _databaseService.getNextState(currentScreen);

    return AppScreen.values.byName(response);
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
    return await _databaseService.signInUser(username, password);
  }

  @override
  Future<bool> initialize() async {
    return true;
  }
}

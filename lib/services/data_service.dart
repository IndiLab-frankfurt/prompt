import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/models/assessment_item.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/internalisation.dart';
import 'package:prompt/models/plan.dart';
import 'package:prompt/models/user_data.dart';
import 'package:collection/collection.dart';
import 'package:prompt/services/i_database_service.dart';
import 'package:prompt/services/local_database_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/usage_stats/usage_info.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/enums.dart';

class DataService {
  final UserService _userService;
  final IDatabaseService _databaseService;
  final LocalDatabaseService _localDatabaseService;
  final SettingsService _settingsService;

  UserData? _userDataCache;
  AssessmentResult? _lastAssessmentResultCache;
  List<AssessmentResult>? _assessmentResultsCache;

  DataService(this._databaseService, this._userService,
      this._localDatabaseService, this._settingsService);

  logData(dynamic data) async {
    data["userid"] = _userService.getUsername();
    if (_userService.isSignedIn()) {
      await _databaseService.logEvent(_userService.getUsername(), data);
    }
  }

  setUserDataCache(UserData ud) async {
    _userDataCache = ud;
  }

  Future<UserData?> getUserData() async {
    var username = _userService.getUsername();
    if (username.isEmpty) return null;
    if (_userDataCache == null) {
      _userDataCache = (await _databaseService.getUserData(username));
    }
    return _userDataCache;
  }

  UserData getUserDataCache() {
    return _userDataCache!;
  }

  saveScore(int score) async {
    var ud = await getUserData();
    ud?.score = score;
    await _databaseService.saveScore(_userService.getUsername(), score);
  }

  saveSessionZeroStep(int step) async {
    var ud = getUserDataCache();
    ud.initSessionStep = step;
    await _databaseService.saveInitSessionStepCompleted(
        _userService.getUsername(), step);
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

  Future<AssessmentResult?> getLastAssessmentResultFor(
      String assessmentName) async {
    List<AssessmentResult> lastResults = [];

    if (_lastAssessmentResultCache == null) {
      lastResults = await getAssessmentResults();
    }
    lastResults.sortBy((element) => element.submissionDate);
    return lastResults
        .lastWhereOrNull((element) => element.assessmentType == assessmentName);
  }

  Future<AssessmentResult?> getLastAssessmentResult() async {
    List<AssessmentResult> lastResults = [];
    if (_lastAssessmentResultCache == null) {
      lastResults = await getAssessmentResults();
    }
    if (lastResults.length == 0) return null;
    return lastResults.sortedBy((element) => element.submissionDate).last;
  }

  Future<List<AssessmentResult>> getAssessmentResults() async {
    if (_assessmentResultsCache == null) {
      var ud = await getUserData();
      _assessmentResultsCache =
          await _databaseService.getAssessmentResults(ud!.user);
    }
    return _assessmentResultsCache!;
  }

  Future<Map<String, dynamic>?> getInitialData() async {
    var ud = await getUserData();
    var initData = await _databaseService.getInitialData(ud!.user);
    return null;
  }

  AssessmentResult? getLastAssessmentResultCached() {
    return _lastAssessmentResultCache;
  }

  saveUsageStats(List<UsageInfo> usageStatInfo, DateTime startDate,
      DateTime endDate) async {
    var ud = getUserDataCache();
    Map<String, dynamic> dbObject = {
      "user": ud.user,
      "submissionDate": DateTime.now().toIso8601String()
    };
    List<dynamic> listForDb = [];
    for (var usi in usageStatInfo) {
      if (usi.totalTimeInForeground > 0) {
        listForDb.add(usi.toMap());
      }
    }
    dbObject["info"] = listForDb;
    dbObject["start"] = startDate.toIso8601String();
    dbObject["end"] = endDate.toIso8601String();

    await _databaseService.saveUsageStats(dbObject, ud.user);
  }

  saveDaysActive(int daysActive) async {
    var ud = await getUserData();
    if (ud != null) {
      ud.daysActive = daysActive;
      await _databaseService.saveDaysAcive(
          _userService.getUsername(), daysActive);
    }
  }

  savePlan(String plan) async {
    var planModel = Plan(plan);
    var ud = getUserDataCache();
    await _databaseService.savePlan(planModel, ud.user);
  }

  saveUserDataProperty(String propertyname, dynamic value) async {
    var ud = getUserDataCache();

    await _databaseService.saveUserDataProperty(ud.user, propertyname, value);
    _userDataCache = await _databaseService.getUserData(ud.user);
  }

  saveBoosterPromptReadTimes(DateTime start, DateTime end) async {
    var map = {
      "user": getUserDataCache().user,
      "start": start.toIso8601String(),
      "end": end.toIso8601String()
    };
    await _databaseService.saveBoosterPromptReadTimes(map);
  }

  saveVocabValue(String vocabValue) async {
    var planModel = Plan(vocabValue);
    var ud = await getUserData();
    await _databaseService.saveVocabValue(planModel, ud!.user);
  }

  Future<Plan?> getLastPlan() async {
    var ud = await getUserData();
    return await _databaseService.getLastPlan(ud!.user);
  }

  setSelectedMascot(String mascot) async {
    var ud = await getUserData();
    if (ud != null) {
      ud.selectedMascot = mascot;
      await saveUserDataProperty("selectedMascot", mascot);
    }
  }

  Future<int> getStreakDays() async {
    var userData = await getUserData();
    if (userData == null) return 0;
    return userData.streakDays;
  }

  Future<String> getSelectedMascot() async {
    var userData = await getUserData();
    if (userData == null) return "1";
    return userData.selectedMascot;
  }

  Future<List<Color>> getBackgroundGradientColors() async {
    var colorString = await _localDatabaseService
        .getSettingsValue(SettingsKeys.backgroundColors);
    if (colorString != null) {
      List<String> colorStringList = colorString.split(",");
      var list =
          colorStringList.map((e) => Color(int.parse(e, radix: 16))).toList();

      return list;
    } else {
      return [Color(0xffffffff), Color(0xffffffff)];
    }
  }

  Future<void> saveAssessment(AssessmentResult assessment) async {
    var arCache = await getAssessmentResults();
    arCache.add(assessment);

    var ud = await getUserData();
    await _databaseService.saveAssessment(assessment, ud!.user);
  }

  Future<void> setBackgroundImage(String imagePath) async {
    await _localDatabaseService.upsertSetting(
        SettingsKeys.backGroundImage, imagePath);
  }

  Future<String?> getBackgroundImagePath() async {
    return await _settingsService.getSetting(SettingsKeys.backGroundImage);
  }

  Future saveBackgroundGradientColors(List<Color> colors) async {
    var colorString = colors
        .map((e) => e.toString().split('(0x')[1].split(')')[0])
        .toList()
        .join(",");
    _localDatabaseService.upsertSetting(
        SettingsKeys.backgroundColors, colorString);
  }

  saveInternalisation(Internalisation internalisation) async {
    return await _databaseService.saveInternalisation(
        internalisation, _userService.getUsername());
  }

  Future<void> setStreakDays(int value) async {
    var ud = await getUserData();
    ud?.streakDays = value;
    return await _databaseService.setStreakDays(
        _userService.getUsername(), value);
  }

  setRegistrationDate(DateTime dateTime) async {
    var ud = await getUserData();
    ud?.registrationDate = dateTime;
    return await _databaseService.setRegistrationDate(
        _userService.getUsername(), dateTime.toIso8601String());
  }

  getAssessment(String name) async {
    String data =
        await rootBundle.loadString("assets/assessments/assessment_$name.json");
    var json = jsonDecode(data);

    var ass = Assessment();
    ass.id = json["id"];
    ass.title = json["title"];
    ass.items = [];
    for (var question in json["questions"]) {
      ass.items.add(AssessmentItem(question["questionText"],
          Map<String, String>.from(question["labels"]), question["id"]));
    }

    return ass;
  }
}

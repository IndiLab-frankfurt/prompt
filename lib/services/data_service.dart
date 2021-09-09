import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/models/assessment_item.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/services/firebase_service.dart';
import 'package:prompt/services/i_database_service.dart';
import 'package:prompt/services/local_database_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/enums.dart';

class DataService {
  final UserService _userService;
  final IDatabaseService _databaseService;
  final LocalDatabaseService _localDatabaseService;
  final SettingsService _settingsService;

  UserData? _userDataCache;
  AssessmentResult? _lastAssessmentResultCache;

  DataService(this._databaseService, this._userService,
      this._localDatabaseService, this._settingsService);

  logData(dynamic data) async {
    data["userid"] = _userService.getUsername();
    if (_userService.isSignedIn()) {
      await _databaseService.logEvent(_userService.getUsername(), data);
    }
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

  Future<AssessmentResult?> getLastAssessmentResult() async {
    var last = _lastAssessmentResultCache;

    if (_lastAssessmentResultCache == null) {
      var ud = await getUserData();
      last = await _databaseService.getLastAssessmentResult(ud!.firebaseId);
    }
    return last;
  }

  AssessmentResult? getLastAssessmentResultCached() {
    return _lastAssessmentResultCache;
  }

  saveDaysActive(int daysActive) async {
    var ud = await getUserData();
    if (ud != null) {
      ud.daysActive = daysActive;
      await _databaseService.saveDaysAcive(
          _userService.getUsername(), daysActive);
    }
  }

  saveSelectedMascot(String mascot) async {
    var ud = await getUserData();
    if (ud != null) {
      ud.selectedMascot = mascot;
      await _databaseService.saveUserDataProperty(
          _userService.getUsername(), "selectedMascot", mascot);
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
    var ud = await getUserData();
    await _databaseService.saveAssessment(assessment, ud!.firebaseId);
  }

  Future<void> setBackgroundImage(String imagePath) async {
    await _localDatabaseService.upsertSetting(
        SettingsKeys.backGroundImage, imagePath);
  }

  Future<String?> getBackgroundImagePath() async {
    return await _settingsService.getSetting(SettingsKeys.backGroundImage);
    // return await _localDatabaseService
    //     .getSettingsValue(SettingsKeys.backGroundImage);
  }

  Future saveBackgroundGradientColors(List<Color> colors) async {
    var colorString = colors
        .map((e) => e.toString().split('(0x')[1].split(')')[0])
        .toList()
        .join(",");
    _localDatabaseService.upsertSetting(
        SettingsKeys.backgroundColors, colorString);
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

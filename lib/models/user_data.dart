import 'dart:io';
import 'package:prompt/shared/extensions.dart';
import 'package:flutter/material.dart';

class UserData {
  String firebaseId = "";
  String user = "";
  int group = 1;
  DateTime registrationDate = DateTime.now();
  DateTime nextPlanReminder = DateTime.now().add(Duration(days: 6));
  int streakDays = 0;
  int score = 0;
  int daysActive = 0;
  int initSessionStep = 0;
  String appVersion = "";
  String selectedMascot = "1";
  String platform = Platform.isAndroid ? "Android" : "iOS";
  TimeOfDay preferredReminderTime = TimeOfDay(hour: 18, minute: 0);

  UserData(
      {required this.firebaseId,
      required this.user,
      this.group = 1,
      required this.registrationDate,
      this.streakDays = 0,
      this.score = 0,
      this.initSessionStep = 0,
      this.appVersion = "",
      this.selectedMascot = "1",
      this.daysActive = 0});

  Map<String, dynamic> toMap() {
    return {
      "firebaseId": this.firebaseId,
      "user": this.user,
      "group": this.group,
      "registrationDate": this.registrationDate.toIso8601String(),
      "preferredReminderTime": this.preferredReminderTime.to24HourString(),
      "streakDays": this.streakDays,
      "score": this.score,
      "daysActive": this.daysActive,
      "initSessionStep": this.initSessionStep,
      "appVersion": this.appVersion,
      "selectedMascot": this.selectedMascot,
      "nextPlanReminder": this.nextPlanReminder.toIso8601String(),
    };
  }

  UserData.fromJson(Map<String, dynamic> json) {
    user = json["user"];
    firebaseId = json["firebaseId"];
    group = json["group"];
    registrationDate = DateTime.parse(json["registrationDate"]);

    if (json.containsKey("score")) {
      score = json["score"];
    }
    if (json.containsKey("streakDays")) {
      streakDays = json["streakDays"];
    }
    if (json.containsKey("daysActive")) {
      daysActive = json["daysActive"];
    }
    if (json.containsKey("initSessionStep")) {
      initSessionStep = json["initSessionStep"];
    }
    if (json.containsKey("appVersion")) {
      appVersion = json["appVersion"];
    }
    if (json.containsKey("selectedMascot")) {
      selectedMascot = json["selectedMascot"];
    }
    if (json.containsKey("preferredReminderTime")) {
      preferredReminderTime = from24HourString(json["preferredReminderTime"]);
    }
    if (json.containsKey("nextPlanReminder")) {
      nextPlanReminder = DateTime.parse(json["nextPlanReminder"]);
    }
  }
}

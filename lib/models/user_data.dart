import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

// part 'UserData.g.dart';
@JsonSerializable()
class UserData {
  String user = "";
  String group = "1";
  DateTime registrationDate = DateTime.now();
  int streakDays = 0;
  int score = 0;
  int daysActive = 0;
  int onboardingStep = 0;
  String appVersion = "";
  String selectedMascot = "1";
  String cabuuCode = "123";
  String platform = kIsWeb ? "Web" : (Platform.isAndroid ? "Android" : "iOS");

  UserData(
      {required this.user,
      this.group = "1",
      required this.registrationDate,
      this.cabuuCode = "123",
      this.streakDays = 0,
      this.score = 0,
      this.onboardingStep = 0,
      this.appVersion = "",
      this.selectedMascot = "1",
      this.daysActive = 0});

  Map<String, dynamic> toMap() {
    return {
      "user": this.user,
      "group": this.group,
      "registrationDate": this.registrationDate.toIso8601String(),
      "streakDays": this.streakDays,
      "score": this.score,
      "daysActive": this.daysActive,
      "initSessionStep": this.onboardingStep,
      "app_version": this.appVersion,
      "selectedMascot": this.selectedMascot,
      "cabuuCode": this.cabuuCode,
    };
  }

  UserData.fromJson(Map<String, dynamic> json) {
    user = json["user"].toString();
    group = json["group"];
    appVersion = json["app_version"];
    onboardingStep = json["init_step"];
    score = json["score"];
  }
}

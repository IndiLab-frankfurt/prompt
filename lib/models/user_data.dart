import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(fromJson: _userFromJson)
  String user = "";
  String group = "1";
  DateTime? startDate = DateTime.now();
  DateTime? reminderTime = DateTime.now();
  int streakDays = 0;
  int score = 0;
  int daysActive = 0;
  int onboardingStep = 0;
  String cabuuCode = "123";
  @JsonKey(includeIfNull: false)
  String? platform = kIsWeb ? "Web" : (Platform.isAndroid ? "Android" : "iOS");

  static String _userFromJson(dynamic user) {
    return user.toString();
  }

  UserData(
      {this.user = "",
      this.group = "1",
      required this.startDate,
      this.cabuuCode = "123",
      this.reminderTime,
      this.streakDays = 0,
      this.score = 0,
      this.onboardingStep = 0,
      this.daysActive = 0});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(fromJson: _userFromJson)
  String username = "";
  String group = "1";

  static toNull(_) => null;
  @JsonKey(toJson: toNull, includeIfNull: false)
  DateTime? startDate = DateTime.now();
  @JsonKey(fromJson: parseTimeAndCombineWithCurrentDate, includeIfNull: false)
  DateTime? reminderTime = DateTime.now();
  int streakDays = 0;
  int score = 0;
  int daysActive = 0;
  int onboardingStep = 0;
  String cabuuCode = "123";
  @JsonKey(includeIfNull: false)
  String? platform = kIsWeb ? "Web" : (Platform.isAndroid ? "Android" : "iOS");

  static DateTime parseTimeAndCombineWithCurrentDate(String timeString) {
    // Parse the time string into a TimeOfDay object
    final timeFormat = DateFormat.Hm();
    final timeOfDay = TimeOfDay.fromDateTime(timeFormat.parse(timeString));

    // Get the current date
    final currentDate = DateTime.now();

    // Combine the current date with the parsed time
    final combinedDateTime = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    return combinedDateTime;
  }

  static String _userFromJson(dynamic user) {
    return user.toString();
  }

  UserData(
      {this.username = "",
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      username: json['username'] == null
          ? ""
          : UserData._userFromJson(json['username']),
      group: json['group'] as String? ?? "1",
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      cabuuCode: json['cabuu_code'] as String? ?? "123",
      reminderTime: json['reminder_time'] == null
          ? null
          : DateTime.parse(json['reminder_time'] as String),
      streakDays: json['streak_days'] as int? ?? 0,
      score: json['score'] as int? ?? 0,
      onboardingStep: json['onboarding_step'] as int? ?? 0,
      daysActive: json['days_active'] as int? ?? 0,
    )..platform = json['platform'] as String?;

Map<String, dynamic> _$UserDataToJson(UserData instance) {
  final val = <String, dynamic>{
    'username': instance.username,
    'group': instance.group,
    'start_date': instance.startDate?.toIso8601String(),
    'reminder_time': instance.reminderTime?.toIso8601String(),
    'streak_days': instance.streakDays,
    'score': instance.score,
    'days_active': instance.daysActive,
    'onboarding_step': instance.onboardingStep,
    'cabuu_code': instance.cabuuCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('platform', instance.platform);
  return val;
}

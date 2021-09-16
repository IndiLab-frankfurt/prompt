/// adapted and modified from https://github.com/Parassharmaa/usage_stats

class UsageInfo {
  UsageInfo(
      {required this.firstTimeStamp,
      required this.lastTimeStamp,
      required this.lastTimeUsed,
      required this.packageName,
      required this.totalTimeInForeground});

  /// Construct class from the json map
  factory UsageInfo.fromMap(Map map) => UsageInfo(
        firstTimeStamp: int.parse(map['firstTimeStamp']),
        lastTimeStamp: int.parse(map['lastTimeStamp']),
        lastTimeUsed: int.parse(map['lastTimeUsed']),
        totalTimeInForeground: int.parse(map['totalTimeInForeground']),
        packageName: map['packageName'],
      );

  final String packageName;
  final int firstTimeStamp;
  final int lastTimeStamp;
  final int lastTimeUsed;
  final int totalTimeInForeground;
}

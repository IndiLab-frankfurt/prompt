/// adapted and modified from https://github.com/Parassharmaa/usage_stats

class EventUsageInfo {
  EventUsageInfo(
      {required this.eventType,
      required this.timeStamp,
      required this.packageName,
      required this.className});

  /// Construct class from the json map
  factory EventUsageInfo.fromMap(Map map) => EventUsageInfo(
      eventType: map['eventType'],
      timeStamp: map['timeStamp'],
      packageName: map['packageName'],
      className: map['className']);

  final String eventType;
  final String timeStamp;
  final String packageName;
  final String className;
}

import 'package:flutter/services.dart';
import 'package:prompt/services/usage_stats/usage_info.dart';

class UsageStatsService {
  static const _channel = MethodChannel('prompt.dipf.de/usage');

  void init() {}

  static Future<void> grantUsagePermission() async {
    var result = await _channel.invokeMethod('grantUsagePermission');
    print(result);
  }

  static Future<List<UsageInfo>> queryUsageStats(
      DateTime startDate, DateTime endDate) async {
    int end = endDate.millisecondsSinceEpoch;
    int start = startDate.millisecondsSinceEpoch;
    Map<String, int> interval = {'start': start, 'end': end};
    List usageStats = await _channel.invokeMethod('queryUsageStats', interval);
    List<UsageInfo> result =
        usageStats.map((item) => UsageInfo.fromMap(item)).toList();

    print(result);
    return result;
  }

  // static List<UsageInfo> filterForegroundApps(List<UsageInfo> usageInfos) {
  //   // return usageInfos
  //   //     .map((e) => (int.parse(e.totalTimeInForeground)))
  //   //     .where((element) => element > 0)
  //   //     .toList();
  // }
}

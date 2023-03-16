import 'dart:async';

import 'package:prompt/services/data_service.dart';

class LoggingService {
  List<Map<String, dynamic>> logs = [];
  DataService _dataService;
  final int batchDuration;
  late Timer _batchTimer;
  LoggingService(this._dataService, {this.batchDuration = 30}) {
    _batchTimer = Timer.periodic(Duration(seconds: batchDuration), (_) {
      _sendBatch();
    });
  }

  String getTimestamp() {
    return DateTime.now().toLocal().toIso8601String();
  }

  logEvent(String eventName, {String? data = ""}) {
    Map<String, String> event = {
      "type": "event",
      "time": getTimestamp(),
      "name": eventName,
      "data": data ?? ""
    };
    logs.add(event);
    // _dataService.logData(event);
  }

  logError(String eventName, {String? data = ""}) {
    print("ERROR: $eventName");
    Map<String, String> event = {
      "type": "error",
      "time": getTimestamp(),
      "name": eventName,
      "data": data ?? ""
    };
    logs.add(event);
    // _dataService.logData(event);
  }

  void _sendBatch() async {
    if (logs.isEmpty) return;
    final batch = logs.toList();
    logs.clear();
    _dataService.sendLogs(batch);
  }

  void dispose() {
    _batchTimer.cancel();
  }
}

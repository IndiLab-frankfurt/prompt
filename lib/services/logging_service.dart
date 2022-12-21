import 'package:prompt/services/data_service.dart';

class LoggingService {
  List<Map<String, dynamic>> logs = [];
  DataService _dataService;
  LoggingService(this._dataService);

  String getTimestamp() {
    return DateTime.now().toIso8601String();
  }

  logEvent(String eventName, {String data = ""}) {
    Map<String, String> event = {
      "type": "event",
      "time": getTimestamp(),
      "name": eventName,
      "data": data
    };
    logs.add(event);
    _dataService.logData(event);
  }

  logError(String eventName, {String data = ""}) {
    print("ERROR: $eventName");
    Map<String, String> event = {
      "type": "error",
      "time": getTimestamp(),
      "name": eventName,
      "data": data
    };
    logs.add(event);
    _dataService.logData(event);
  }
}

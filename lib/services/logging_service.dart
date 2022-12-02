import 'package:prompt/services/data_service.dart';

class LoggingService {
  List<Map<String, dynamic>> logs = [];
  DataService _dataService;
  LoggingService(this._dataService);

  getTimestamp() {
    return DateTime.now().toIso8601String();
  }

  logData(String data) {}

  logEvent(String eventName, {Map<String, dynamic>? data}) {
    Map<String, dynamic> event = {
      "type": "event",
      "time": getTimestamp(),
      "name": eventName,
      "data": data
    };
    logs.add(event);
    _dataService.logData(event);
    print(event);
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

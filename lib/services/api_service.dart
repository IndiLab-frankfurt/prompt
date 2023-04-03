import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:prompt/models/authentication_response.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/models/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:prompt/services/dialog_service.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/extensions.dart';

class ApiService {
  // static String serverUrl = "http://10.0.2.2:8000";
  String serverUrl = "https://prompt-app.eu";

  final SettingsService _settingsService;

  Future<bool> initialize() {
    if (kIsWeb || !kDebugMode) {
      serverUrl = _settingsService.getSetting(SettingsKeys.apiBaseUrl);
    } else if (kDebugMode) {
      // serverUrl = "https://prompt-app.eu";
      serverUrl = "http://10.0.2.2:8000";
    }
    return Future.value(true);
  }

  Map<String, String> getHeaders() {
    var username = _settingsService.getSetting(SettingsKeys.username);
    var password = _settingsService.getSetting(SettingsKeys.password);
    String basicAuth =
        "Basic " + base64Encode(utf8.encode('$username:$password'));
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "authorization": basicAuth
    };
    return headers;
  }

  Future<dynamic> getAsync(String endpoint,
      {Map<String, String>? queryParams}) async {
    var url = Uri.parse("$serverUrl$endpoint");
    if (queryParams != null) {
      url = url.replace(queryParameters: queryParams);
    }
    try {
      var response = await http.get(url, headers: getHeaders()).timeout(
          Duration(seconds: 20),
          onTimeout: () => throw ArgumentError("Timeout"));
      return response;
    } on ArgumentError catch (e) {
      print(e);
      await locator<DialogService>().showDialog(
          title: "Server nicht erreichbar",
          description:
              "Bitte überprüfe deine Internetverbindung und versuche es erneut.");
      // try again
      return this.getAsync(endpoint, queryParams: queryParams);
    }
  }

  Future<Response?> postAsync(String endpoint, dynamic data,
      {Map<String, String>? queryParams}) async {
    var url = Uri.parse("$serverUrl$endpoint");
    if (queryParams != null) {
      url = url.replace(queryParameters: queryParams);
    }
    try {
      var response = await http
          .post(url, headers: getHeaders(), body: jsonEncode(data))
          .timeout(Duration(seconds: 20),
              onTimeout: () => throw ArgumentError("Timeout"));
      return response;
    } on ArgumentError catch (e) {
      print(e);
      await locator<DialogService>().showDialog(
          title: "Server nicht erreichbar",
          description:
              "Bitte überprüfe deine Internetverbindung und versuche es erneut.");
      // try again
      return this.postAsync(endpoint, data, queryParams: queryParams);
    }
  }

  Future<bool> submitQuestionnaireResponses(dynamic responses) {
    var params = {"local_time": DateTime.now().toTimeZoneAwareISOString()};
    return postAsync("/api/questionnaires/", responses, queryParams: params)
        .then((response) => response != null && response.statusCode == 200);
  }

  ApiService(this._settingsService);

  Future<QuestionnaireResponse?> getLastQuestionnaireResponse(
      String questionName) async {
    return getAsync("/api/responses/$questionName/?latest=True")
        .then((response) {
      var data = response.body;
      if (data != null && data != "" && data != "[]") {
        try {
          return QuestionnaireResponse.fromJson(jsonDecode(data)[0]);
        } catch (e) {
          logEvents([
            {"data": "error parsing questionnaire response", "error": "$e"}
          ]);
          return null;
        }
      } else {
        return null;
      }
    });
  }

  Future<String?> getLastPlan() async {
    var result = await getLastQuestionnaireResponse("plan");
    if (result != null) {
      return result.response;
    } else {
      return null;
    }
  }

  Future<UserData?> getUserData() async {
    var response = await getAsync("/api/user/profile/");
    if (response == null) {
      return null;
    }
    if (response.statusCode == 200) {
      var data = response.body;
      var userData = UserData.fromJson(jsonDecode(data));
      return userData;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  updateUserData(UserData userData) {
    return postAsync("/api/user/profile/", userData.toJson());
  }

  Future<Map<String, dynamic>?> saveUserDataProperty(
      String key, dynamic value) async {
    var response = await postAsync("/api/user/profile/", {key: value});
    if (response == null) {
      return null;
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  logEvents(List<dynamic> data) async {
    return postAsync("/api/applogs/", data);
  }

  Future<dynamic> saveQuestionnaireResponses(
      List<QuestionnaireResponse> responses) {
    var responseJson = responses.map((e) => e.toJson()).toList();
    return postAsync("/api/responses/", responseJson).then((response) {
      if (response == null) {
        return null;
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    });
  }

  saveScrambleCorrections(corrections) {
    throw UnimplementedError();
  }

  Future deleteAccount() async {
    return postAsync("/api/user/deleteself/", {});
  }

  Future<String> getNextState(String currentState) async {
    var params = {
      "current_state": currentState,
      "local_time": DateTime.now().toTimeZoneAwareISOString()
    };
    return getAsync("/api/nextstate/", queryParams: params).then((response) =>
        response.statusCode == 200
            ? jsonDecode(response.body)["next_state"]
            : "");
  }

  Future<AuthenticationResponse?> signInUser(
      String userId, String password) async {
    var result = await postAsync(
        "/api/token/", {"username": userId, "password": password});
    if (result == null) {
      return null;
    }
    if (result.statusCode == 200) {
      var data = result.body;
      var accessToken = jsonDecode(data)["access"];
      var refreshToken = jsonDecode(data)["refresh"];
      return AuthenticationResponse(
          accessToken: accessToken, refreshToken: refreshToken);
    } else {
      return null;
    }
  }

  Future<int> getRewardScore(String lastQuestionnaire) async {
    var params = {"local_time": DateTime.now().toTimeZoneAwareISOString()};
    return getAsync("/api/user/reward/", queryParams: params).then((response) =>
        response.statusCode == 200 ? jsonDecode(response.body)["score"] : 0);
  }
}

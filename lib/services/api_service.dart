import 'dart:convert';
import 'package:prompt/models/authentication_response.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/models/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:prompt/services/settings_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:prompt/shared/enums.dart';

class ApiService {
  static String serverUrl = "http://10.0.2.2:8000";

  final SettingsService _settingsService;

  Future<bool> initialize() {
    if (kIsWeb || !kDebugMode) {
      serverUrl = "https://prompt-app.eu";
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
      var response = await http.get(url, headers: getHeaders());
      return response;
    } on ArgumentError catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> postAsync(String endpoint, dynamic data) async {
    var url = Uri.parse("$serverUrl$endpoint");

    try {
      var response =
          await http.post(url, headers: getHeaders(), body: jsonEncode(data));
      return response;
    } on ArgumentError catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> submitQuestionnaireResponses(dynamic responses) {
    return postAsync("/api/questionnaires/", responses).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    });
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
          logEvent(
              {"data": "error parsing questionnaire response", "error": "$e"});
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

  Future saveUserDataProperty(String key, dynamic value) {
    return postAsync("/api/user/profile/", {key: value});
  }

  logEvent(Map<String, String> data) async {
    return postAsync("/api/applogs/", data);
  }

  Future<bool> saveQuestionnaireResponses(
      List<QuestionnaireResponse> responses) {
    var responseJson = responses.map((e) => e.toJson()).toList();
    return postAsync("/api/responses/", responseJson).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future saveDaysAcive(String username, int daysActive) {
    // TODO: implement saveDaysAcive
    throw UnimplementedError();
  }

  Future<void> saveOnboardingStepCompleted(String userid, int step) {
    // TODO: implement saveInitSessionStepCompleted
    throw UnimplementedError();
  }

  Future<void> savePlan(String plan) {
    // TODO: implement savePlan
    throw UnimplementedError();
  }

  Future<void> saveScore(String userid, int score) {
    // TODO: implement saveScore
    throw UnimplementedError();
  }

  saveScrambleCorrections(corrections) {
    throw UnimplementedError();
  }

  Future<String> getNextState(String currentState) async {
    var params = {
      "current_state": currentState,
      "local_time": DateTime.now().toLocal().toIso8601String()
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
}

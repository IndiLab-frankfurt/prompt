// Test all the API endpoints
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/services/api_service.dart';

import 'mocks/mock_services.dart';

void main() {
  group("Creation and Retrieval of objects", () {
    ApiService apiService;

    Future<void> setUp(dynamic Function() body) async {
      apiService = await getMockApiService();
    }

    test("Insert and retrieve a questionnaire response", () async {});
  });
}

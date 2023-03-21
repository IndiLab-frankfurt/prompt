import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';

import 'mocks/mock_services.dart';

void main() {
  late MockStudyService _mockStudyService = MockStudyService();

  setUp(() {
    // Create the dashboard view model
    _mockStudyService = MockStudyService();
  });
}

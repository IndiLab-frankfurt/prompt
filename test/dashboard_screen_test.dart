import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';

import 'mocks/mock_services.dart';

void main() {
  late MockStudyService _mockStudyService = MockStudyService();

  setUp(() {
    // Create the dashboard view model
    _mockStudyService = MockStudyService();
  });

  test("Display correct message according to day", () async {
    // Create the dashboard view model
    var vm = DashboardViewModel(_mockStudyService);

    _mockStudyService.daysSinceStart = 0;
    await expectLater(vm.getButtonText(), "Morgen geht es richtig los!");

    _mockStudyService.daysSinceStart = 0;
    await expectLater(vm.getButtonText(), "Morgen geht es richtig los!");
  });
}

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/viewmodels/morning_assessment_view_model.dart';

import 'mocks/mock_services.dart';

void main() {
  var vm = MorningAssessmentViewModel(mockExperimentService, mockDataService);
  test("Each group should have each internalisation condition", () {
    List<int> conditionsSeen = [];
    for (var group = 1; group <= ExperimentService.NUM_GROUPS; group++) {
      for (var day = 0; day < 37; day++) {
        conditionsSeen.add(mockExperimentService
            .getInternalisationConditionForGroupAndDay(group, day));
      }
    }

    print(conditionsSeen);
    expect(conditionsSeen.reduce(max) == 2, true);
    expect(conditionsSeen.reduce(min) == 0, true);
    expect(conditionsSeen.contains(0), true);
    expect(conditionsSeen.contains(1), true);
    expect(conditionsSeen.contains(2), true);
  });
}

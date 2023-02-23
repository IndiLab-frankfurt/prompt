import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_services.dart';

void main() {
  test("Percentage of reward progress gets calculated correctly", () {
    var rewardService = mockRewardService;
    rewardService.scoreValue = 0;

    var sortedRewardValues = rewardService.unlockValues.values.toList();
    sortedRewardValues.sort();

    expect(sortedRewardValues[0], 0);

    expect(rewardService.getRewardProgress(sortedRewardValues[0]), 0);

    expect(
        rewardService.getRewardProgress(
            sortedRewardValues[sortedRewardValues.length - 1]),
        1);

    expect(
        rewardService.getRewardProgress(
            sortedRewardValues[sortedRewardValues.length ~/ 2 + 1]),
        greaterThanOrEqualTo(.5));

    expect(
        rewardService.getRewardProgress(
            sortedRewardValues[sortedRewardValues.length ~/ 2 - 1]),
        lessThanOrEqualTo(.5));
  });
}

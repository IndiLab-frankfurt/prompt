import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/services/user_service.dart';

void main() {
  test('Group 1 should be larger than all other groups', () {
    // Verify that our counter has incremented.
    // expService.schedulePrompts(1);
    var groupResults = [];
    for (var i = 0; i < 5000; i++) {
      groupResults.add(UserService.getGroup());
    }

    var numberOfOnes = groupResults
        .map((element) => element == 1 ? 1 : 0)
        .reduce((value, element) => value + element);
    var numberOfTwos = groupResults
        .map((element) => element == 2 ? 1 : 0)
        .reduce((value, element) => value + element);
    var threes = groupResults
        .map((element) => element == 3 ? 1 : 0)
        .reduce((value, element) => value + element);
    var fours = groupResults
        .map((element) => element == 4 ? 1 : 0)
        .reduce((value, element) => value + element);
    var fives = groupResults
        .map((element) => element == 5 ? 1 : 0)
        .reduce((value, element) => value + element);
    var sixes = groupResults
        .map((element) => element == 6 ? 1 : 0)
        .reduce((value, element) => value + element);
    expect(numberOfOnes > numberOfTwos, true);
    expect(numberOfOnes > threes, true);
    expect(numberOfOnes > fours, true);
    expect(numberOfOnes > fives, true);
    expect(numberOfOnes > sixes, true);
  });
}

import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class InternalisationViewModel extends BaseViewModel {
  String plan = "Wenn ich nach Hause komme, esse ich eine Wurst";

  bool completed = false;

  String input = "";

  void onScrambleCorrection(String text) {}

  void submit(InternalisationCondition condition, String input) {
    completed = true;
    input = input;
  }
}

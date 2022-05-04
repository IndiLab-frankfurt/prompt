import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class InternalisationViewModel extends BaseViewModel {
  InternalisationViewModel();

  InternalisationViewModel.withCondition(this.condition);

  String plan = "Wenn ich lernen will, dann konzentriere ich mich";

  InternalisationCondition condition = InternalisationCondition.waiting;

  bool completed = false;

  String input = "";

  DateTime startDate = DateTime.now();

  void onScrambleCorrection(String text) {}

  void submit(InternalisationCondition condition, String input) {
    this.condition = condition;
    completed = true;
    this.input = input;
  }
}

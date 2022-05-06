import 'package:prompt/viewmodels/base_view_model.dart';

class PlanViewModel extends BaseViewModel {
  String _plan = "";
  String get plan => _plan;

  set plan(String plan) {
    _plan = plan;
    notifyListeners();
  }

  String getIfPart(String input) {
    var ifPartStart = input.indexOf("Wenn");
    var thenPartStart = input.indexOf("dann");
    if (ifPartStart == -1) {
      return "";
    }
    return plan.substring(ifPartStart + 5, thenPartStart);
  }

  String getThenPart(String input) {
    var thenPartStart = input.indexOf("dann");
    if (thenPartStart == -1) {
      return "";
    }
    return plan.substring(thenPartStart + 3, plan.length);
  }

  String getFullPlanFromIfPart(String ifPart) {
    // Attach a comma to the end
    if (ifPart.lastIndexOf(",") != ifPart.length - 1) {
      ifPart = ifPart + ",";
    }
    return "Wenn $ifPart dann lerne ich Vokabeln!";
  }
}

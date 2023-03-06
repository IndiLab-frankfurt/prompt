import 'package:prompt/viewmodels/base_view_model.dart';

abstract class QuestionnairePageViewModel extends BaseViewModel {
  final String name;
  bool completed = false;
  Function? onAnswered;
  QuestionnairePageViewModel(this.name);
}

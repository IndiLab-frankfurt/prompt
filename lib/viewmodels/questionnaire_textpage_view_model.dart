import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class QuestionnaireTextPageViewModel extends QuestionnairePageViewModel {
  final List<String> text;

  QuestionnaireTextPageViewModel({required this.text, required String name})
      : super(name);
}

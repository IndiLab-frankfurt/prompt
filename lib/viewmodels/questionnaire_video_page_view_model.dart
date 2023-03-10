import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class QuestionnaireVideoPageViewModel extends QuestionnairePageViewModel {
  final String videoUrl;

  QuestionnaireVideoPageViewModel(
      {required String name, required this.videoUrl})
      : super(name: name);

  onVideoCompleted() {
    if (!completed) {
      response = QuestionnaireResponse(
          name: name,
          questionnaireName: name,
          questionText: videoUrl,
          response: "Video completed",
          dateSubmitted: DateTime.now().toLocal());
      onAnswered?.call(response!);
      notifyListeners();
    }
    completed = true;
  }
}

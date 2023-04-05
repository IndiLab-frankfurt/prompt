import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class ChoiceQuestionViewModel extends QuestionnairePageViewModel {
  final bool singleChoice;
  final bool randomize;
  final Map<String, String> choices;
  final String questionText;
  final String instructions;
  List<String> selectedChoices = [];

  ChoiceQuestionViewModel(
      {required String name,
      required this.choices,
      required this.questionText,
      bool completed = false,
      this.randomize = false,
      this.instructions = "",
      this.singleChoice = true})
      : super(name: name) {
    this.completed = completed;
  }

  randomizeMap(Map<String, String> map) {
    Map<String, String> newmap = {};
    var list = List<int>.generate(map.length, (i) => i + 1);
    list.shuffle();
    for (var i in list) {
      var existingKey = map.keys.elementAt(i);
      var existingValue = map.values.elementAt(i);
      newmap[existingKey] = existingValue;
    }

    return newmap;
  }

  onSingleChoiceSelection(String selectedValue) {
    // map the groupValue to the index of the choice in the list of choices
    selectedChoices = [selectedValue];

    var response = QuestionnaireResponse(
      dateSubmitted: DateTime.now().toLocal(),
      name: name,
      questionnaireName: "",
      questionText: questionText,
      response: selectedValue,
    );

    completed = true;

    onAnswered?.call(response);

    notifyListeners();
  }

  onMultipleChoiceSelection(String selectedValue) {
    // check if the selected value is already in the list
    if (selectedChoices.contains(selectedValue)) {
      // if it is, remove it
      selectedChoices.remove(selectedValue);
    } else {
      // if it is not, add it
      selectedChoices.add(selectedValue);
    }

    var response = QuestionnaireResponse(
      dateSubmitted: DateTime.now().toLocal(),
      name: name,
      questionnaireName: "",
      questionText: questionText,
      response: selectedValue,
    );

    completed = true;

    onAnswered?.call(response);

    notifyListeners();
  }

  onSelection(String selectedValue) {
    if (singleChoice) {
      onSingleChoiceSelection(selectedValue);
    } else {
      onMultipleChoiceSelection(selectedValue);
    }
    notifyListeners();
  }
}

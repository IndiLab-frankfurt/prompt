import 'package:flutter/foundation.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

class MultiPageQuestionnaireViewModel extends MultiPageViewModel {
  final Questionnaire questionnaire;
  MultiPageQuestionnaireViewModel(DataService dataService,
      {required this.questionnaire})
      : super(dataService);

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return true;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    return true;
  }

  @override
  void submit() {
    // TODO: implement submit
  }
}

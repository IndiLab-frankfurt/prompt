import 'package:prompt/models/question.dart';

class Questionnaire {
  String id = "";
  List<Question> items = [];
  String title = "";

  Questionnaire({required this.id, required this.title, required this.items});
}

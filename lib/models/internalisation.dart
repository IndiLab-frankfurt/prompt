class Internalisation {
  DateTime startDate = DateTime.now();
  DateTime completionDate = DateTime.now();
  String plan = "";
  String condition = "";
  String input = "";
  int planId = 1;

  Internalisation(
      {required this.startDate,
      required this.completionDate,
      this.plan = "",
      this.condition = "",
      this.input = "",
      this.planId = 1});

  Internalisation.fromDocument(dynamic document) {
    this.completionDate = DateTime.parse(document["completionDate"]);
    this.startDate = DateTime.parse(document["startDate"]);
    this.condition = document["condition"];

    if (document["plan"] != null) {
      this.plan = document["plan"];
    }
    if (document["input"] != null) {
      this.input = document["input"];
    }
    if (document["planId"] != null) {
      this.planId = document["planId"];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "startDate": this.startDate.toIso8601String(),
      "completionDate": this.completionDate.toIso8601String(),
      "plan": this.plan,
      "condition": this.condition,
      "input": this.input,
      "planId": this.planId
    };
  }
}

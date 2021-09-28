class Plan {
  String plan = "";
  DateTime submissionDate = DateTime.now();

  Plan(this.plan);

  Map<String, dynamic> toMap() {
    return {
      "plan": this.plan,
      "submissionDate": this.submissionDate.toIso8601String(),
    };
  }

  Plan.fromDocument(dynamic document) {
    this.plan = document["plan"];
    this.submissionDate = DateTime.parse(document["submissionDate"]);
  }
}

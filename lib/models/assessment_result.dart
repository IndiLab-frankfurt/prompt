class AssessmentResult {
  Map<String, String> results = {};
  String assessmentType = "";
  DateTime submissionDate = DateTime.now();
  DateTime startDate = DateTime.now();

  AssessmentResult(this.results, this.assessmentType, this.submissionDate);

  Map<String, dynamic> toMap() {
    return {
      "results": this.results,
      "assessmentType": this.assessmentType,
      "submissionDate": this.submissionDate.toIso8601String(),
      "startDate": this.startDate.toIso8601String()
    };
  }

  AssessmentResult.fromDocument(dynamic document) {
    this.submissionDate = DateTime.parse(document["submissionDate"]);
    this.assessmentType = document["assessmentType"];
  }
}

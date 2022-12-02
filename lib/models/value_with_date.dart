class ValueWithDate {
  dynamic value = "";
  DateTime date = DateTime.now();

  ValueWithDate(this.value, this.date);

  @override
  String toString() {
    return 'ValueWithDate{value: $value, date: $date}';
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'date': date.toIso8601String(),
    };
  }

  ValueWithDate.fromDocument(dynamic document) {
    this.value = document["value"];
    this.date = DateTime.parse(document["date"]);
  }
}

class Selectable {
  String name = "";
  String description = "";
  bool isSelected = false;
  String iconPath = "";

  Selectable(
      {this.name = "",
      this.description = "",
      this.iconPath = "",
      this.isSelected = false});

  Selectable.fromDocument(dynamic document) {
    this.name = document["name"];
    this.description = document["description"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "description": this.description,
    };
  }
}

import 'package:flutter/material.dart';
import 'package:prompt/models/selectable.dart';

class SelectableItem extends StatefulWidget {
  final Function(Selectable) onItemSelected;
  final Selectable selectable;
  const SelectableItem(
    this.selectable,
    this.onItemSelected, {
    Key? key,
  }) : super(key: key);

  @override
  State<SelectableItem> createState() => _SelectableItemState();
}

class _SelectableItemState extends State<SelectableItem> {
  bool isSelected = false;

  @override
  void initState() {
    isSelected = widget.selectable.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Theme.of(context).selectedRowColor : Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black54, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset(widget.selectable.iconPath),
        title: Text(widget.selectable.description),
        subtitle: Text(""),
        isThreeLine: true,
        onTap: () async {
          widget.selectable.isSelected = !widget.selectable.isSelected;
          widget.onItemSelected(widget.selectable);
          setState(() => {isSelected = widget.selectable.isSelected});
        },
      ),
    );
  }
}

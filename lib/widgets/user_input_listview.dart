import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/sortable_list_view_model.dart';
import 'package:provider/provider.dart';

class UserInputListView extends StatefulWidget {
  UserInputListView({Key? key}) : super(key: key);

  @override
  _UserInputListViewState createState() => _UserInputListViewState();
}

class _UserInputListViewState extends State<UserInputListView> {
  List<TextField> _customOutcomes = [];

  @override
  void initState() {
    super.initState();
  }

  buildTextField(String key) {
    var vm = Provider.of<SortableListViewModel>(context, listen: false);

    return Row(
      children: [
        Flexible(
          flex: 9,
          child: TextField(
            decoration: InputDecoration(hintText: 'Gib etwas ein'),
            onChanged: (String text) {
              setState(() {});
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: IconButton(
              onPressed: () {
                vm.removeSelectedItem(key);
                setState(() {});
              },
              icon: Icon(Icons.delete)),
        ),
      ],
    );
  }

  buildAddButton() {
    var vm = Provider.of<SortableListViewModel>(context, listen: false);
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200, height: 50),
      child: ElevatedButton.icon(
          onPressed: () {
            setState(() {});
            vm.addSelectedItem();
          },
          icon: Icon(Icons.add),
          label: Text("Weiteren Eintrag hinzufügen")),
    );
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SortableListViewModel>(context, listen: false);
    List<Widget> children = [];

    for (var custom in vm.selectedItems) {
      if (custom.name.contains("custom")) {
        children.add(buildTextField(custom.name));
      }
    }

    return Container(
      child: Column(
        children: [
          UIHelper.verticalSpaceMedium(),
          Text("", style: Theme.of(context).textTheme.subtitle1),
          UIHelper.verticalSpaceMedium(),
          Expanded(
              child: ListView(
            shrinkWrap: true,
            children: children,
          )),
          UIHelper.verticalSpaceMedium(),
          buildAddButton()
        ],
      ),
    );
  }
}

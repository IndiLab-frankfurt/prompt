import 'package:flutter/material.dart';
import 'package:prompt/models/selectable.dart';

import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/sortable_list_view_model.dart';
import 'package:provider/provider.dart';

class SortableSelectionList extends StatefulWidget {
  final String headerText;

  SortableSelectionList({
    Key? key,
    required this.headerText,
  }) : super(key: key);

  @override
  State<SortableSelectionList> createState() => _SortableSelectionListState();
}

class _SortableSelectionListState extends State<SortableSelectionList> {
  late var vm;

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<SortableListViewModel>(context);
    return ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          vm.reorderItems(oldIndex, newIndex);
        },
        header: buildHeader(context),
        children: List.generate(vm.selectedItems.length, (index) {
          return _buildSelectableItem(context, vm.selectedItems[index]);
        }));
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      children: [
        UIHelper.verticalSpaceMedium(),
        Text(
          widget.headerText,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        UIHelper.verticalSpaceMedium(),
      ],
    );
  }

  _buildSelectableItem(BuildContext context, Selectable selectable) {
    var upDownArrow = Column(
      children: [
        IconButton(
          icon: Icon(Icons.keyboard_arrow_up),
          onPressed: () {
            _itemUp(selectable);
          },
        ),
        IconButton(
          icon: Icon(Icons.keyboard_arrow_down),
          onPressed: () {
            _itemDown(selectable);
          },
        ),
      ],
    );
    var content = Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        UIHelper.horizontalSpaceSmall(),
        Image.asset(
          selectable.iconPath,
          width: 44,
          height: 44,
        ),
        UIHelper.horizontalSpaceMedium(),
        Expanded(flex: 1, child: Text(selectable.description)),
        upDownArrow
      ],
    ));

    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        key: ValueKey(selectable.name),
        child: content);
  }

  _itemUp(Selectable selectable) {
    var index = vm.selectedItems.indexOf(selectable);
    vm.swapItems(index, index - 1);
  }

  _itemDown(Selectable selectable) {
    var index = vm.selectedItems.indexOf(selectable);
    vm.swapItems(index, index + 1);
  }
}

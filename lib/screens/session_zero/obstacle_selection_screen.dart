import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/sortable_list_view_model.dart';
import 'package:prompt/widgets/selectable_item.dart';
import 'package:provider/provider.dart';

class ObstacleSelectionScreen extends StatefulWidget {
  ObstacleSelectionScreen({Key? key}) : super(key: key);

  @override
  _ObstacleSelectionScreenState createState() =>
      _ObstacleSelectionScreenState();
}

class _ObstacleSelectionScreenState extends State<ObstacleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: buildObstacleList(context));
  }

  buildObstacleList(BuildContext context) {
    var vm = Provider.of<SortableListViewModel>(context);

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        UIHelper.verticalSpaceMedium(),
        Text(
          "Was sind Hindernisse, die dich davon abhalten, mit dem Vokabellernen anzufangen oder die dich während des Vokabellernens stören? Wähle alle Hindernisse aus, die auf dich zutreffen - auch wenn sie nur manchmal zutreffen.",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        UIHelper.verticalSpaceMedium(),
        for (var item in vm.availableItems)
          SelectableItem(item, vm.itemSelected),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/sortable_list_view_model.dart';
import 'package:prompt/widgets/selectable_item.dart';
import 'package:provider/provider.dart';

class OutcomeSelectionScreen extends StatefulWidget {
  OutcomeSelectionScreen({Key? key}) : super(key: key);

  @override
  _OutcomeSelectionScreenState createState() => _OutcomeSelectionScreenState();
}

class _OutcomeSelectionScreenState extends State<OutcomeSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: buildOutcomeList(context));
  }

  buildOutcomeList(BuildContext context) {
    var vm = Provider.of<SortableListViewModel>(context);

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
          data:
              "### Was wäre gut daran, wenn du es schaffen würdest, regelmäßig Vokabeln zu lernen? Wähle die Dinge aus, die für dich am wichtigsten sind.",
        ),
        UIHelper.verticalSpaceMedium(),
        for (var item in vm.availableItems)
          SelectableItem(item, vm.itemSelected),
        MarkdownBody(
          data:
              "Du kannst auf der nächsten Seite noch eigene Sachen hinzufügen.",
        ),
      ],
    );
  }
}

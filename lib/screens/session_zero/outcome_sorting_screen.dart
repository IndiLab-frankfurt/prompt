import 'package:flutter/material.dart';
import 'package:prompt/widgets/sortable_selection_list.dart';

class OutcomeSortingScreen extends StatelessWidget {
  const OutcomeSortingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SortableSelectionList(
          headerText:
              "Sortiere die möglichen Ziele danach, wie wichtig sie dir sind"),
    );
  }
}

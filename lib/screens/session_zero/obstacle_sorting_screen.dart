// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:prompt/shared/ui_helper.dart';
// import 'package:provider/provider.dart';
// import 'package:prompt/models/obstacle.dart';
// import 'package:prompt/shared/ui_helpers.dart';
// import 'package:prompt/viewmodels/init_session_view_model.dart';

// class ObstacleSortingScreen extends StatefulWidget {
//   ObstacleSortingScreen({Key key}) : super(key: key);

//   @override
//   _ObstacleSortingScreenState createState() => _ObstacleSortingScreenState();
// }

// class _ObstacleSortingScreenState extends State<ObstacleSortingScreen> {
//   _reorderObstacleList(int oldIndex, int newIndex) {
//     if (newIndex > oldIndex) {
//       newIndex -= 1;
//     }

//     setState(() {
//       final vm = Provider.of<InitSessionViewModel>(context, listen: false);
//       final items = vm.selectedObstacles.removeAt(oldIndex);
//       vm.selectedObstacles.insert(newIndex, items);
//     });
//   }

//   _swapItems(int indexA, int indexB) {
//     final vm = Provider.of<InitSessionViewModel>(context, listen: false);
//     if (indexA < 0 || indexB < 0) return;
//     if (indexA > (vm.selectedObstacles.length - 1) ||
//         indexB > (vm.selectedObstacles.length - 1)) return;
//     var tmpB = vm.selectedObstacles[indexB];
//     vm.selectedObstacles[indexB] = vm.selectedObstacles[indexA];
//     vm.selectedObstacles[indexA] = tmpB;
//   }

//   _obstacleUp(Obstacle obstacle) {
//     final vm = Provider.of<InitSessionViewModel>(context, listen: false);
//     var index = vm.selectedObstacles.indexOf(obstacle);
//     setState(() {
//       _swapItems(index, index - 1);
//     });
//   }

//   _obstacleDown(Obstacle obstacle) {
//     final vm = Provider.of<InitSessionViewModel>(context, listen: false);
//     var index = vm.selectedObstacles.indexOf(obstacle);
//     setState(() {
//       _swapItems(index, index + 1);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(child: buildObstacleList(context), height: 700);
//   }

//   _buildHindranceItem(BuildContext context, Obstacle obstacle) {
//     var upDownArrow = Column(
//       children: [
//         IconButton(
//           icon: Icon(Icons.keyboard_arrow_up),
//           onPressed: () {
//             _obstacleUp(obstacle);
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.keyboard_arrow_down),
//           onPressed: () {
//             _obstacleDown(obstacle);
//           },
//         ),
//       ],
//     );

//     var content = Container(
//         child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         UIHelper.horizontalSpaceSmall(),
//         Image.asset(
//           obstacle.iconPath,
//           width: 44,
//           height: 44,
//         ),
//         UIHelper.horizontalSpaceMedium(),
//         Expanded(flex: 1, child: Text(obstacle.description)),
//         upDownArrow
//       ],
//     ));

//     return Card(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: Colors.black54, width: 1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         key: ValueKey(obstacle.name),
//         child: content);
//   }

//   buildObstacleList(BuildContext context) {
//     var vm = Provider.of<InitSessionViewModel>(context);

//     var buildHeader = Column(
//       children: [
//         UIHelper.verticalSpaceMedium(),
//         Text(
//           "Sortiere die Hindernisse nach Wichtigkeit, indem du sie an die entsprechende Stelle verschiebst. Das größte Hindernis sollte ganz oben sein.",
//           style: Theme.of(context).textTheme.subtitle1,
//         ),
//         UIHelper.verticalSpaceMedium(),
//       ],
//     );

//     return ReorderableListView(
//         onReorder: (int oldIndex, int newIndex) {
//           _reorderObstacleList(oldIndex, newIndex);
//         },
//         header: buildHeader,
//         children: List.generate(vm.selectedObstacles.length, (index) {
//           return _buildHindranceItem(context, vm.selectedObstacles[index]);
//         }));
//   }
// }

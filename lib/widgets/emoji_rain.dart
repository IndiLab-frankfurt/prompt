import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class Item {
  static final random = Random();
  late double _size;
  late Color _color;
  late Alignment _alignment;

  Item() {
    // _color = Color.fromARGB(random.nextInt(255), random.nextInt(255),
    //     random.nextInt(255), random.nextInt(255));
    _alignment =
        Alignment(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1);
    _size = 25;
  }
}

class EmojiRain extends StatefulWidget {
  final int numberOfItems;

  const EmojiRain({Key? key, required this.numberOfItems}) : super(key: key);

  @override
  _EmojiRainState createState() => _EmojiRainState();
}

class _EmojiRainState extends State<EmojiRain>
    with SingleTickerProviderStateMixin {
  var items = <Item>[];
  var started = false;

  late AnimationController animationController;
  late GravitySimulation simulation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RaisedButton(
          child: Text("Start Dropping"),
          onPressed: makeItems,
        ),
        ...buildItems()
      ],
    );
  }

  List<Widget> buildItems() {
    return items.map((item) {
      return Positioned(
        top: animationController.value,
        left: item._alignment.x * item._size,
        right: item._alignment.x * item._size,
        child: Container(
          width: item._size,
          height: item._size,
          // color: item._color,
          child: Text(
            "💎",
            style: TextStyle(fontSize: item._size),
          ),
        ),
      );
      // var tween = Tween<Offset>(
      //         begin: Offset(0, -.5),
      //         end: Offset(Random().nextDouble() * 0.5, 2))
      //     .chain(CurveTween(curve: Curves.linear));
      // return SlideTransition(
      //   position: animationController.drive(tween),
      //   child: AnimatedAlign(
      //     alignment: item._alignment,
      //     duration: Duration(seconds: 3),
      //     child: Container(
      //       width: item._size,
      //       height: item._size,
      //       // color: item._color,
      //       child: Text(
      //         "💎",
      //         style: TextStyle(fontSize: item._size),
      //       ),
      //     ),
      //     // child: AnimatedContainer(
      //     //   duration: Duration(seconds: 10),
      //     //   width: item._size,
      //     //   height: item._size,
      //     //   decoration:
      //     //       BoxDecoration(color: item._color, shape: BoxShape.circle),
      //     // ),
      //   ),
      // );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 4), upperBound: 150)
      ..addListener(() {
        setState(() {});
      });

    simulation = GravitySimulation(
      500.0, // acceleration
      0.0, // starting point
      250.0, // end point
      20.0, // starting velocity
    );
    simulation.isDone(5);
    // animationController.animateWith(simulation);
  }

  void makeItems() {
    setState(() {
      items.clear();
      for (int i = 0; i < widget.numberOfItems; i++) {
        items.add(Item());
      }
    });

    animationController.reset();
    animationController.animateWith(simulation);
    animationController.forward();
  }
}

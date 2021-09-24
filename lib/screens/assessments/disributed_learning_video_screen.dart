import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prompt/widgets/video_screen.dart';

class DistributedLearningVideo extends StatefulWidget {
  DistributedLearningVideo({Key? key}) : super(key: key);

  @override
  _DistributedLearningVideoState createState() =>
      _DistributedLearningVideoState();
}

class _DistributedLearningVideoState extends State<DistributedLearningVideo> {
  void onVideoCompleted() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: VideoScreen(
      'assets/videos/videoLearning.mp4',
      onVideoCompleted: onVideoCompleted,
    )));
  }
}

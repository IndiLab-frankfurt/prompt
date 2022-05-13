import 'package:flutter/material.dart';
import 'package:prompt/screens/main/prompt_single_screen.dart';
import 'package:prompt/widgets/video_screen.dart';

class VideoCreatePlanScreen extends StatelessWidget {
  const VideoCreatePlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PromptSingleScreen(
        child: VideoScreen(
      onVideoCompleted: () {},
      videoURL: "assets/videos/WennDannPlan.mp4",
    ));
  }
}

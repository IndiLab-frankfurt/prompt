import 'package:flutter/material.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:prompt/widgets/video_screen.dart';

class AboutVideoScreen extends StatelessWidget {
  const AboutVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PromptAppBar(
          showBackButton: true,
        ),
        body: VideoScreen('assets/videos/videoLearning.mp4',
            onVideoCompleted: () {}));
  }
}

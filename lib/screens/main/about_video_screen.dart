import 'package:flutter/material.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/screens/main/video_screen.dart';

class AboutVideoScreen extends StatelessWidget {
  const AboutVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PromptAppBar(
          showBackButton: true,
        ),
        body: VideoScreen('assets/videos/intro_prompt_compressed.mp4',
            onVideoCompleted: () {}));
  }
}

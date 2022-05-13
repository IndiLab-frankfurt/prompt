import 'package:flutter/material.dart';
import 'package:prompt/screens/main/prompt_single_screen.dart';
import 'package:prompt/widgets/video_screen.dart';

class SingleVideoScreen extends StatefulWidget {
  final String videoURL;
  final VoidCallback onVideoCompleted;
  const SingleVideoScreen(
      {Key? key, required this.videoURL, required this.onVideoCompleted})
      : super(key: key);

  @override
  State<SingleVideoScreen> createState() => _SingleVideoScreenState();
}

class _SingleVideoScreenState extends State<SingleVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return PromptSingleScreen(
        child: VideoScreen(
            videoURL: widget.videoURL,
            onVideoCompleted: widget.onVideoCompleted));
  }
}

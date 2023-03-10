import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoURL;
  final VoidCallback onVideoCompleted;

  const VideoScreen(this.videoURL, {required this.onVideoCompleted, Key? key})
      : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset(widget.videoURL);
  late ChewieController _videoController = ChewieController(
    videoPlayerController: _videoPlayerController,
    allowFullScreen: false,
    aspectRatio: 9 / 16,
  );

  @override
  void initState() {
    super.initState();

    _videoPlayerController.addListener(() {
      if (!_videoPlayerController.value.isInitialized) return;

      var timeToFinish = _videoPlayerController.value.duration.inSeconds -
          _videoPlayerController.value.position.inSeconds;
      if (timeToFinish < 5) {
        widget.onVideoCompleted();
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Chewie(
      controller: _videoController,
    ));
  }
}

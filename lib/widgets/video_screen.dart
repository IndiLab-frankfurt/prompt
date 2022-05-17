import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoScreen extends StatefulWidget {
  final String videoURL;
  final VoidCallback onVideoCompleted;

  const VideoScreen(
      {required this.videoURL, required this.onVideoCompleted, Key? key})
      : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late Future _initialized = _videoPlayerController.initialize();

  late VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset(widget.videoURL);

  late ChewieController _chewieController = ChewieController(
    videoPlayerController: _videoPlayerController,
    looping: false,
    showControls: true,
    // autoInitialize: true,
    aspectRatio: 9 / 16,
  );

  @override
  void initState() {
    super.initState();

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.isInitialized) {
        checkIfCompleted();
      }
    });
    // Prevent the app from going to sleep while the video is playing
    Wakelock.enable();
  }

  void checkIfCompleted() {
    var timeToFinish = _videoPlayerController.value.duration.inSeconds -
        _videoPlayerController.value.position.inSeconds;
    if (timeToFinish < 2) {
      widget.onVideoCompleted();
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialized,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                child: Chewie(
              controller: _chewieController,
            ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:prompt/widgets/video_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.file,
    //     'assets/videos/cabuu_test_lernplan.mp4');
    // _betterPlayerController = BetterPlayerController(
    //     BetterPlayerConfiguration(),
    //     betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PromptAppBar(
          showBackButton: true,
        ),
        drawer: PromptDrawer(),
        body: VideoScreen('assets/videos/cabuu_test_lernplan.mp4',
            onVideoCompleted: () {})
        // body: AspectRatio(
        //   aspectRatio: 9 / 16,
        //   child: BetterPlayer(
        //     controller: _betterPlayerController,
        //   ),
        // ),
        );
  }
}

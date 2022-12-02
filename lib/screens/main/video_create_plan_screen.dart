import 'package:flutter/material.dart';
import 'package:prompt/screens/main/prompt_single_screen.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:prompt/widgets/video_screen.dart';

class VideoCreatePlanScreen extends StatefulWidget {
  const VideoCreatePlanScreen({Key? key}) : super(key: key);

  @override
  State<VideoCreatePlanScreen> createState() => _VideoCreatePlanScreenState();
}

class _VideoCreatePlanScreenState extends State<VideoCreatePlanScreen> {
  bool videoCompleted = false;

  @override
  Widget build(BuildContext context) {
    return PromptSingleScreen(
        child: Column(
      children: [
        Flexible(
          child: VideoScreen(
            onVideoCompleted: () {
              setState(() {
                videoCompleted = true;
              });
            },
            videoURL: "assets/videos/WennDannPlan.mp4",
          ),
        ),
        UIHelper.verticalSpaceSmall(),
        _buildSubmitButton()
      ],
    ));
  }

  _buildSubmitButton() {
    if (videoCompleted) {
      return FullWidthButton(
        onPressed: () async {
          Navigator.pushNamed(context, RouteNames.NO_TASKS);
        },
        text: "Weiter",
      );
    } else {
      return Container();
    }
  }
}

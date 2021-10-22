import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:prompt/widgets/video_screen.dart';

class PreVocabVideo extends StatefulWidget {
  final VoidCallback onVideoCompleted;
  final DateTime nextLearnDate;
  const PreVocabVideo(
      {required this.onVideoCompleted, Key? key, required this.nextLearnDate})
      : super(key: key);

  @override
  _PreVocabVideoState createState() => _PreVocabVideoState();
}

class _PreVocabVideoState extends State<PreVocabVideo> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.75;
    var format = new DateFormat("dd.MM.yyyy");
    var targetDate = format.format(widget.nextLearnDate);
    return Container(
        child: ListView(
      children: [
        Container(
            height: height,
            child: VideoScreen('assets/videos/cabuu_test_lernplan.mp4',
                onVideoCompleted: widget.onVideoCompleted)),
        MarkdownBody(data: "### Dein nächster Lernplan endet am: $targetDate")
      ],
    ));
  }
}

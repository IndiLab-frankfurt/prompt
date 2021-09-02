import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:prompt/screens/internalisation/internalisation_screen.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:provider/provider.dart';
import 'package:prompt/shared/enums.dart';
import 'package:collection/collection.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/widgets/speech_bubble.dart';

class ScrambleText {
  int originalPosition;
  bool isSelected;
  String text;

  ScrambleText(
      {required this.originalPosition,
      required this.isSelected,
      required this.text});

  static randomizeList(List list) {
    var random = new Random();
    for (var i = list.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = list[i];
      list[i] = list[n];
      list[n] = temp;
    }

    return list;
  }

  static List<ScrambleText> scrambleTextListFromString(String text, int step) {
    List<ScrambleText> output = [];
    var shieldSentence = text.split(" ");
    var index = 0;
    while (index < shieldSentence.length) {
      var sentenceChunk = "";
      for (var j = 0; j < step; j++) {
        if ((index + j) < (shieldSentence.length)) {
          sentenceChunk += shieldSentence[index + j];
        }
        // Add whitespace except for the last character to not have trailing whitespace
        if ((index + j) < shieldSentence.length - 1) {
          sentenceChunk += " ";
        }
      }
      index += step;
      var st = ScrambleText(
          isSelected: false, text: sentenceChunk, originalPosition: 0);
      output.add(st);
    }
    return output;
  }

  static String stringFromScrambleTextList(List<ScrambleText> list) {
    return list.map((st) => st.text).toList().join();
  }
}

class ScrambleInternalisation extends StatefulWidget {
  final OnCompletedCallback? onCompleted;
  const ScrambleInternalisation({this.onCompleted});

  @override
  _ScrambleInternalisationState createState() =>
      _ScrambleInternalisationState();
}

class _ScrambleInternalisationState extends State<ScrambleInternalisation> {
  List<ScrambleText> _scrambledSentence = [];
  String _correctSentence = "";
  List<ScrambleText> _builtSentence = [];
  Duration fadeOutDuration = Duration(seconds: 1);
  bool _showPlan = true;
  bool _showPuzzle = false;
  int _timesWrong = 0;
  String _originalSentence = "";

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      var vm = Provider.of<InternalisationViewModel>(context, listen: false);
      _originalSentence = vm.plan;
      _correctSentence = _cleanInputString(vm.plan);
      setState(() {
        _scrambledSentence = ScrambleText.randomizeList(
            ScrambleText.scrambleTextListFromString(_correctSentence, 1));
      });

      Timer(Duration(seconds: 1), () {
        setState(() {
          _showPlan = false;
          _showPuzzle = true;
        });
      });
    });
  }

  String _cleanInputString(String input) {
    return input.replaceAll("**", "").replaceAll("#", "");
  }

  _wrongTooOften() {
    return _timesWrong >= 3;
  }

  _isDone() {
    var built = ScrambleText.stringFromScrambleTextList(_builtSentence);
    return (built == _correctSentence);
  }

  _allChunksUsed() {
    var selectedScramble =
        _scrambledSentence.firstWhereOrNull((element) => !element.isSelected);

    return selectedScramble == null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                UIHelper.verticalSpaceMedium(),
                _buildCorrectText(_originalSentence),
                UIHelper.verticalSpaceMedium(),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    children: [
                      Wrap(
                        children: <Widget>[
                          for (var s in _builtSentence)
                            if (s.isSelected) buildWordBox(s),
                        ],
                      ),
                      UIHelper.verticalSpaceMedium(),
                      Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: _builtSentence.length > 0,
                        child: _buildDeleteButton(),
                      ),
                    ],
                  ),
                ),

                // _buildDragDrop(),
                if (_allChunksUsed() && !_isDone()) _buildIncorrectWarning(),

                Visibility(
                  visible: _showPuzzle,
                  child: Wrap(
                    children: <Widget>[
                      for (var s in _scrambledSentence)
                        if (!s.isSelected)
                          Stack(children: [
                            buildEmptyWord(s.text),
                            buildWordBox(s)
                          ])
                        else
                          buildEmptyWord(s.text)
                    ],
                  ),
                ),
                UIHelper.verticalSpaceLarge(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildWordBox(ScrambleText scramble) {
    return GestureDetector(
      onTap: () {
        // _builtSentence.add(scramble);
        _scrambleTextClick(scramble);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.orange[200],
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 0.5)]),
        child: Text(
          scramble.text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        margin: EdgeInsets.all(1.0),
        padding: EdgeInsets.all(6.0),
      ),
    );
  }

  _scrambleTextClick(ScrambleText scramble) {
    var vm = Provider.of<InternalisationViewModel>(context, listen: false);
    setState(() {
      scramble.isSelected = !scramble.isSelected;
      print(scramble.isSelected);
      if (scramble.isSelected) {
        _builtSentence.add(scramble);
        setState(() {});
      } else {
        vm.onScrambleCorrection(_builtSentence.last.text);
        _builtSentence.remove(scramble);
      }

      if (_isDone() || _wrongTooOften()) _complete();
    });
  }

  buildEmptyWord(String text) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   _builtSentence.add(text);
        // });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[600],
        ),
        child: Opacity(opacity: 0, child: Text(text)),
        margin: EdgeInsets.all(1.0),
        padding: EdgeInsets.all(6.0),
      ),
    );
  }

  _buildDeleteButton() {
    return Container(
      width: 250,
      child: OutlinedButton(
          child: Row(
            children: [
              Icon(Icons.backspace),
              UIHelper.horizontalSpaceMedium(),
              Text(
                "Letzte Eingabe Löschen",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          onPressed: () {
            try {
              setState(() {
                if (_builtSentence.length > 0) {
                  var last = _builtSentence.last;
                  _scrambleTextClick(last);
                }
              });
            } catch (e) {
              print(e.toString());
            }
          }),
    );
  }

  _complete() {
    if (widget.onCompleted != null) {
      // var condition = InternalisationCondition.scrambleWithHint;
      var built = "";
      if (_builtSentence.length > 0) {
        built = ScrambleText.stringFromScrambleTextList(_builtSentence);
      }

      widget.onCompleted!(built);
    }
  }

  _buildSubmitButton() {
    var vm = Provider.of<InternalisationViewModel>(context, listen: false);
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () async {
              var condition = InternalisationCondition.scrambleWithHint;
              var built = "";
              if (_builtSentence.length > 0) {
                built = ScrambleText.stringFromScrambleTextList(_builtSentence);
              }

              vm.submit(condition, built);
            },
            child: Text("Weiter", style: TextStyle(fontSize: 20)),
          )),
    );
  }

  _buildCorrectText(String text) {
    return AnimatedOpacity(
        opacity: this._showPlan ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: Column(
          children: [
            Text(
              "Merke dir folgenden Satz, und puzzle ihn dann gleich zusammen:",
              style: Theme.of(context).textTheme.headline6,
            ),
            UIHelper.verticalSpaceMedium(),
            SpeechBubble(text: text),
          ],
        ));
  }

  _buildIncorrectWarning() {
    _timesWrong += 1;
    return Container(
      color: Colors.red[100],
      child: Center(
          child: Column(
        children: [
          (Text(
            "Der Satz ist so leider nicht richtig. Versuche es doch weiter.",
            style: TextStyle(fontSize: 20),
          )),
          if (_timesWrong >= 3)
            Text(
              "Wenn du nicht mehr magst, versuche trotzdem, dir den Plan so gut wie möglich zu merken, und drücke dann auf 'Weiter'.",
              style: TextStyle(fontSize: 20),
            ),
        ],
      )),
      margin: EdgeInsets.fromLTRB(2, 10, 2, 20),
      padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
    );
  }

  buildPuzzle() {
    return Wrap(
      children: <Widget>[
        for (var s in _scrambledSentence)
          if (!s.isSelected)
            Stack(children: [buildEmptyWord(s.text), buildWordBox(s)])
          else
            buildEmptyWord(s.text)
      ],
    );
  }
}

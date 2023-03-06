import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/widgets/speech_bubble.dart';
import 'package:provider/provider.dart';

class EmojiInternalisationScreen extends StatefulWidget {
  final InternalisationViewModel vm;

  EmojiInternalisationScreen({Key? key, required this.vm}) : super(key: key);

  @override
  _EmojiInternalisationScreenState createState() =>
      _EmojiInternalisationScreenState();
}

class _EmojiInternalisationScreenState
    extends State<EmojiInternalisationScreen> {
  late InternalisationViewModel vm;

  bool _done = false;

  List<Emoji> emojiNamesLeft = [];
  List<Emoji> emojiNamesRight = [];

  bool emojiInputIf = true;
  bool emojiInputThen = true;

  final TextEditingController _controllerLeft = TextEditingController();
  final TextEditingController _controllerRight = TextEditingController();

  late TextEditingController _activeController = _controllerLeft;

  @override
  void initState() {
    super.initState();
    emojiInputIf = (widget.vm.condition == InternalisationCondition.emojiIf) ||
        (widget.vm.condition == InternalisationCondition.emojiBoth);

    emojiInputThen =
        (widget.vm.condition == InternalisationCondition.emojiThen) ||
            (widget.vm.condition == InternalisationCondition.emojiBoth);

    if (emojiInputIf) {
      _activeController = _controllerLeft;
    } else {
      _activeController = _controllerRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: this.widget.vm,
        builder: (context, child) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      MarkdownBody(
                          data: "### " +
                              AppStrings.EmojiInternalisation_Instruction),
                      UIHelper.verticalSpaceSmall,
                      SpeechBubble(
                          text:
                              '"${Provider.of<InternalisationViewModel>(context).plan}"'),
                      UIHelper.verticalSpaceSmall,
                      _buildEmojiPickerCompatibleTextInput(),
                      UIHelper.verticalSpaceMedium,
                      _buildEmojiPicker(),
                      UIHelper.verticalSpaceMedium,
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildEmojiPickerCompatibleTextInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (this.emojiInputIf) _buildEmojiInputLeft(),
        if (!this.emojiInputIf) _buildIfPart(),
        if (this.emojiInputThen) _buildEmojiInputRight(),
        if (!this.emojiInputThen) _builThenPart()
      ],
    );
  }

  _buildIfPart() {
    var width = MediaQuery.of(context).size.width * 0.42;
    var ifPart = this.widget.vm.getIfPart();
    return Container(width: width, child: MarkdownBody(data: "## $ifPart"));
  }

  _builThenPart() {
    var width = MediaQuery.of(context).size.width * 0.42;
    var thenPart = this.widget.vm.getThenPart();
    return Container(width: width, child: MarkdownBody(data: "## $thenPart"));
  }

  _buildEmojiInputLeft() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Wenn..."),
        _buildEmojiInput(_controllerLeft, emojiNamesLeft),
      ],
    );
  }

  _buildEmojiInputRight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("dann..."),
        _buildEmojiInput(_controllerRight, emojiNamesRight),
      ],
    );
  }

  Widget _buildEmojiInput(
      TextEditingController controller, List<Emoji> activeEmojiList) {
    var width = MediaQuery.of(context).size.width * 0.42;
    return Container(
        width: width,
        child: Stack(children: [
          TextField(
            minLines: 2,
            maxLines: 3,
            controller: controller,
            autofocus: true,
            autocorrect: false,
            readOnly: true,
            enableSuggestions: false,
            enableInteractiveSelection: false,
            style: Theme.of(context).textTheme.headline6,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            onChanged: (text) {
              setState(() {
                _checkIfIsDone();
              });
            },
            onTap: () {
              setState(() {
                _activeController = controller;
                _checkIfIsDone();
              });
            },
          ),
          Positioned(
              top: 0.0,
              right: 0.0,
              child: IconButton(
                  icon: Icon(Icons.backspace),
                  onPressed: () {
                    if (activeEmojiList.length > 0) {
                      activeEmojiList.removeAt(activeEmojiList.length - 1);
                    }
                    controller.text = textFromEmojiList(activeEmojiList);

                    _checkIfIsDone();
                  })),
        ]));
  }

  String textFromEmojiList(List<Emoji> emojiList) {
    if (emojiList.length == 0) return "";
    return emojiList.map((e) => e.emoji).toList().join("");
  }

  String emojiNamesFromEmojiList(List<Emoji> emojiList) {
    if (emojiList.length == 0) return "";
    return emojiList.map((e) => e.name).toList().join("-");
  }

  _buildEmojiPicker() {
    return SizedBox(
      height: 300,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) => {
          setState(() {
            // custom logic to enable backspace in the textfield
            if (_activeController == _controllerLeft) {
              emojiNamesLeft.add(emoji);
            } else {
              emojiNamesRight.add(emoji);
            }
            _checkIfIsDone();
          })
        },
        textEditingController: _activeController,
        config: Config(
          columns: 8,
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: const Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: false,
          showRecentsTab: false,
          recentsLimit: 28,
          replaceEmojiOnLimitExceed: false,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ),
          loadingIndicator: const SizedBox.shrink(),
          tabIndicatorAnimDuration: kTabScrollDuration,
          buttonMode: ButtonMode.MATERIAL,
          checkPlatformCompatibility: true,
        ),
      ),
    );
    // var emojiKeyboard = EmojiKeyboard(
    //   onEmojiSelected: (Emoji emoji) {
    //     setState(() {
    //       _activeController.text += emoji.text;
    //       // Log whether the emoji was left or right
    //       var left = _activeController == _controllerLeft;
    //       if (left) {
    //         emojiNamesLeft.add(emoji);
    //       } else {
    //         emojiNamesRight.add(emoji);
    //       }
    //     });
    //     _checkIfIsDone();
    //   },
    // );
    // return emojiKeyboard;
  }

  String _getEmojiInput() {
    var rawInput =
        "Wenn ${_controllerLeft.text}, dann ${_controllerRight.text}";
    var emojiInfoLeft = emojiNamesFromEmojiList(emojiNamesLeft);
    var emojiInfoRight = emojiNamesFromEmojiList(emojiNamesRight);
    return "$rawInput ---- L:$emojiInfoLeft | R:$emojiInfoRight";
  }

  void _checkIfIsDone() {
    var leftSide = this.emojiInputIf ? _controllerLeft.text.isNotEmpty : true;
    var rightSide =
        this.emojiInputThen ? _controllerRight.text.isNotEmpty : true;
    _done = leftSide && rightSide;

    if (_done) {
      var input = _getEmojiInput();
      this.widget.vm.onComplete(input);
    }
  }
}

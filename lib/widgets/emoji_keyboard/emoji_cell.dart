import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prompt/widgets/emoji_keyboard/base_emoji.dart';
import 'package:prompt/widgets/emoji_keyboard/emoji_keyboard_widget.dart';

class EmojiCell extends StatelessWidget {
  final Emoji emoji;
  final OnEmojiSelected onEmojiSelected;

  const EmojiCell(
      {Key? key, required this.emoji, required this.onEmojiSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      key: ValueKey('${emoji.text}'),
      pressedOpacity: 0.4,
      padding: EdgeInsets.all(0),
      child: Center(
        child: Text(
          '${emoji.text}',
          style: TextStyle(
            fontSize: 26,
          ),
        ),
      ),
      onPressed: () => onEmojiSelected(emoji),
    );
  }
}

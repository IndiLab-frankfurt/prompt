import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/widgets/emoji_keyboard/all_emojis.dart';
import 'package:prompt/widgets/emoji_keyboard/emoji_keyboard_widget.dart';

void main() {
  test("Count the number of emojis in the emoji keyboard", () {
    print(emojiList.length);
    expect(emojiList.length, greaterThan(10));
  });
}

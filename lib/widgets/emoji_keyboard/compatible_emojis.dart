import 'dart:io';

import 'package:flutter/foundation.dart';

import 'base_emoji.dart';
import 'all_emojis.dart';
import 'package:device_info/device_info.dart';

void _emojiDispatcher(Emoji emoji) {
  switch (emoji.category) {
    case EmojiCategory.people:
      _emojis[0].add(emoji);
      break;
    case EmojiCategory.nature:
      _emojis[1].add(emoji);
      break;
    case EmojiCategory.food:
      _emojis[2].add(emoji);
      break;
    case EmojiCategory.activity:
      _emojis[3].add(emoji);
      break;
    case EmojiCategory.travel:
      _emojis[4].add(emoji);
      break;
    case EmojiCategory.objects:
      _emojis[5].add(emoji);
      break;
    case EmojiCategory.symbols:
      _emojis[6].add(emoji);
      break;
    case EmojiCategory.flags:
      _emojis[7].add(emoji);
      break;
  }
}

typedef Compatible = bool Function(Emoji emoji, String systemVersion);

Future<bool> _getCompatibleEmojis(
    String systemVersion, bool useDiversity) async {
  final _deviceInfoPlugin = DeviceInfoPlugin();

  Compatible isCompatible = Emoji.isAndroidCompatible;

  if (!kIsWeb) {
    if (Platform.isAndroid) {
      systemVersion = (await _deviceInfoPlugin.androidInfo).version.release;
      isCompatible = Emoji.isAndroidCompatible;
    } else if (Platform.isIOS) {
      systemVersion = (await _deviceInfoPlugin.iosInfo).systemVersion;
      isCompatible = Emoji.isIOSCompatible;
    } else {
      isCompatible = (_, __) => true;
    }
  }

  for (final emoji in emojiList) {
    if (isCompatible(emoji, systemVersion)) {
      _emojiDispatcher(emoji);
      if (useDiversity) {
        emoji.diversityChildren.forEach((childEmoji) {
          if (isCompatible(childEmoji, systemVersion)) {
            _emojiDispatcher(childEmoji);
          }
        });
      }
    }
  }
  return true;
}

bool _loaded = false;
final List<List<Emoji>> _emojis = List.generate(8, (_) => <Emoji>[]);

Future<List<List<Emoji>>> getEmojis(
    {String systemVersion = "", bool useDiversity = false}) async {
  if (!_loaded) {
    _loaded = await _getCompatibleEmojis(systemVersion, useDiversity);
  }
  return _emojis;
}

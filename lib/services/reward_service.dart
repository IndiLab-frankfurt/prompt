import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prompt/models/unlockable_background.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/logging_service.dart';

class RewardService {
  late StreamController<int> controller = StreamController.broadcast();
  int scoreValue = 0;
  int gems = 0;
  int daysActive = 0;
  int streakDays = 0;
  final Color backgroundBase = Color(0xFFFFF3E0);
  String backgroundImagePath = "assets/illustrations/mascot_1_bare.png";
  String selectedMascot = "1";
  static const int STREAK_THRESHOLD = 5;
  // LinearGradient _baseGradient =
  LinearGradient backgroundColor = LinearGradient(
    colors: [Colors.orange, Colors.orange],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  final DataService _dataService;
  final LoggingService _logService;

  final List<int> unlockDays = [
    0,
    1,
    3,
  ];

  List<UnlockableBackground> get backgrounds {
    return getBackgroundImages(selectedMascot);
  }

  RewardService(this._dataService, this._logService);

  Future retrieveScore() async {
    await _dataService.getScore().then((s) {
      scoreValue = s;
      controller.add(s);
      return s;
    });
  }

  Future getDaysActive() async {
    await _dataService.getDaysActive().then((s) {
      daysActive = s;
      return s;
    });
  }

  Future<int> getStreakDays() async {
    return await _dataService.getStreakDays().then((s) {
      streakDays = s;
      return s;
    });
  }

  Future getMasot() async {
    return await _dataService.getSelectedMascot().then((path) {
      this.selectedMascot = path;
      return path;
    });
  }

  Future getBackgroundImagePath() async {
    _dataService.getBackgroundImagePath().then((path) {
      if (path != null && path.isNotEmpty) {
        this.backgroundImagePath = path;
      }

      return backgroundImagePath;
    });
  }

  Future<List<Color>> getBackgroundColors() async {
    _dataService.getBackgroundGradientColors().then((colors) {
      var bgColor = LinearGradient(
        colors: colors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
      // setBackgroundColor(bgColor);
      this.backgroundColor = bgColor;

      return colors;
    });
    return backgroundColor.colors;
  }

  Future initialize() async {
    await getBackgroundColors();
    await getBackgroundImagePath();
    await retrieveScore();
    await getDaysActive();
    await getStreakDays();
    await getMasot();
  }

  getBackgroundImages(String mascotId) {
    return [
      UnlockableBackground(
          "Monster",
          "assets/illustrations/mascot_${mascotId}_bare.png",
          0,
          LinearGradient(colors: [backgroundBase, backgroundBase])),
      UnlockableBackground(
          "Flugzeug",
          "assets/illustrations/backgrounds/mascot_${mascotId}_plane_2.png",
          0,
          LinearGradient(colors: [backgroundBase, Color(0xff9fc7f0)])),
      UnlockableBackground(
          "Weltraum 1",
          "assets/illustrations/backgrounds/mascot_${mascotId}_space_1.png",
          1,
          LinearGradient(colors: [backgroundBase, Color(0xff08111f)])),
      UnlockableBackground(
          "Pyramiden",
          "assets/illustrations/backgrounds/mascot_${mascotId}_pyramid.png",
          3,
          LinearGradient(colors: [backgroundBase, Color(0xffa2d0ff)])),
      UnlockableBackground(
          "Vulkan 1",
          "assets/illustrations/backgrounds/mascot_${mascotId}_vulcan_1.png",
          6,
          LinearGradient(colors: [backgroundBase, Color(0xffb7c6d6)])),
      UnlockableBackground(
          "Wikinger",
          "assets/illustrations/backgrounds/mascot_${mascotId}_viking_1.png",
          9,
          LinearGradient(colors: [backgroundBase, Color(0xff08172e)])),
      UnlockableBackground(
          "Ozean 1",
          "assets/illustrations/backgrounds/mascot_ocean_2.png",
          12,
          LinearGradient(colors: [backgroundBase, Color(0xff97b9d3)])),
      UnlockableBackground(
          "Pyramide 2",
          "assets/illustrations/backgrounds/mascot_${mascotId}_pyramid_2.png",
          15,
          LinearGradient(colors: [backgroundBase, Color(0xffa2d0ff)])),
      UnlockableBackground(
          "Weltraum",
          "assets/illustrations/backgrounds/mascot_${mascotId}_space_2.png",
          18,
          LinearGradient(colors: [backgroundBase, Color(0xff08111f)])),
      UnlockableBackground(
          "Vulkan 2",
          "assets/illustrations/backgrounds/mascot_${mascotId}_vulcan_2.png",
          21,
          LinearGradient(colors: [backgroundBase, Color(0xffb7c6d6)])),
      UnlockableBackground(
          "Wikinger 2",
          "assets/illustrations/backgrounds/mascot_${mascotId}_viking_2.png",
          24,
          LinearGradient(colors: [backgroundBase, Color(0xff08172e)])),
      UnlockableBackground(
          "Zauberei 2",
          "assets/illustrations/backgrounds/mascot_${mascotId}_wizard_2.png",
          27,
          LinearGradient(colors: [backgroundBase, Color(0xffccdcf6)])),
    ];
  }

  setBackgroundImagePath(String imagePath) async {
    this.backgroundImagePath = imagePath;
    _logService.logEvent("backgroundImageChanged", data: {"path": imagePath});
    await this._dataService.setBackgroundImage(imagePath);
  }

  setBackgroundColor(LinearGradient lg) async {
    this.backgroundColor = LinearGradient(
      colors: lg.colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    await this._dataService.saveBackgroundGradientColors(lg.colors);
  }

  onRecallTask() async {
    int points = 10 + streakDays;
    await addPoints(points);
  }

  onFinalTask() async {
    await addPoints(10);
  }

  onLdtInitialLongLdtFinished() async {
    await addPoints(5);
  }

  onRecallTaskEverythingCompleted() async {}

  addDaysActive(int days) async {
    daysActive += days;
    await _dataService.saveDaysActive(daysActive);
  }

  addPoints(int points) async {
    scoreValue += points;
    controller.add(scoreValue);
    await _dataService.saveScore(scoreValue);
  }

  addStreakDays(int days) async {
    streakDays += days;
    await _dataService.setStreakDays(streakDays);
  }

  clearStreakDays() async {
    streakDays = ((streakDays / STREAK_THRESHOLD).floor() * STREAK_THRESHOLD);
    await _dataService.setStreakDays(streakDays);
  }
}

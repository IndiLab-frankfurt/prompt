import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prompt/models/unlockable_background.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/shared/ui_helper.dart';

class RewardService {
  late StreamController<int> controller = StreamController.broadcast();
  int scoreValue = 0;
  int gems = 0;
  int daysActive = 0;
  int streakDays = 0;
  static final pointsForMorningAssessment = 10;
  final Color backgroundBase = Color(0xFFFFF3E0);
  final Color backGroundViking = Color(0xff061021);
  final Color backgroundPlane = Color(0xff9fc7f0);
  final Color backgroundSpace = Color(0xff08111f);
  final Color backgroundVulcan = Color(0xffb7c6d6);
  final Color backgroundWizard = Color(0xffccdcf6);
  final Color backgroundPyramid = Color(0xffa2d0ff);
  final Color backgroundOcean = Color(0xff97b9d3);
  String backgroundImagePath = "assets/illustrations/mascot_1_bare.png";
  String _selectedMascot = "1";
  String get selectedMascot => _selectedMascot;
  static const int STREAK_THRESHOLD = 5;

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
    return getBackgroundImages(_selectedMascot);
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
      this._selectedMascot = path;
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

  void changeMascot(String newMascot) {
    var m = "mascot_";
    var indexof = this.backgroundImagePath.lastIndexOf(m);
    var replaced = this
        .backgroundImagePath
        .replaceRange(indexof + m.length, indexof + m.length + 1, newMascot);
    this.backgroundImagePath = replaced;
    this._selectedMascot = newMascot;
  }

  Future<List<Color>> getBackgroundColors() async {
    _dataService.getBackgroundGradientColors().then((colors) {
      var bgColor = LinearGradient(
        colors: colors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

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

  getUnlockDays(String background, int group) {
    var unlockDays = {
      "Monster": {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0},
      "Flugzeug": {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0},
      "Weltraum 1": {1: 4, 2: 3, 3: 3, 4: 3, 5: 3, 6: 3},
      "Pyramiden 1": {1: 8, 2: 6, 3: 6, 4: 6, 5: 6, 6: 6},
      "Vulkan 1": {1: 12, 2: 9, 3: 9, 4: 9, 5: 9, 6: 9},
      "Wikinger 1": {1: 16, 2: 12, 3: 12, 4: 12, 5: 12, 6: 12},
      "Ozean 1": {1: 21, 2: 15, 3: 15, 4: 15, 5: 15, 6: 15},
      "Pyramiden 2": {1: 25, 2: 18, 3: 18, 4: 18, 5: 18, 6: 18},
      "Zauberei 1": {1: 30, 2: 21, 3: 21, 4: 21, 5: 21, 6: 21},
      "Weltraum 2": {1: 34, 2: 24, 3: 24, 4: 24, 5: 24, 6: 24},
      "Vulkan 2": {1: 38, 2: 27, 3: 27, 4: 27, 5: 27, 6: 27},
      "Ozean 2": {1: 43, 2: 30, 3: 30, 4: 30, 5: 30, 6: 30},
      "Wikinger 2": {1: 47, 2: 33, 3: 33, 4: 33, 5: 33, 6: 33},
      "Zauberei 2": {1: 52, 2: 36, 3: 36, 4: 36, 5: 36, 6: 36},
    };
    if (unlockDays.containsKey(background)) {
      if (unlockDays[background]!.containsKey(group)) {
        return unlockDays[background]![group];
      }
    }
    return 0;
  }

  getBackgroundImages(String mascotId) {
    var grp = _dataService.getUserDataCache().group;
    return [
      UnlockableBackground(
          "Monster",
          "assets/illustrations/mascot_${mascotId}_bare.png",
          getUnlockDays("Monster", grp),
          LinearGradient(
              colors: [UIHelper.bgGradientStart, UIHelper.bgGradientEnd])),
      UnlockableBackground(
          "Flugzeug",
          "assets/illustrations/mascot_${mascotId}_plane_2.png",
          getUnlockDays("Flugzeug", grp),
          LinearGradient(colors: [backgroundBase, backgroundPlane])),
      UnlockableBackground(
          "Weltraum 1",
          "assets/illustrations/mascot_${mascotId}_space_1.png",
          getUnlockDays("Weltraum 1", grp),
          LinearGradient(colors: [backgroundBase, backgroundSpace])),
      UnlockableBackground(
          "Vulkan 1",
          "assets/illustrations/mascot_${mascotId}_vulcan_1.png",
          getUnlockDays("Vulkan 1", grp),
          LinearGradient(colors: [backgroundBase, backgroundVulcan])),
      UnlockableBackground(
          "Pyramiden 1",
          "assets/illustrations/mascot_${mascotId}_pyramid_1.png",
          getUnlockDays("Pyramiden 1", grp),
          LinearGradient(colors: [backgroundBase, backgroundPyramid])),
      UnlockableBackground(
          "Wikinger 1",
          "assets/illustrations/mascot_${mascotId}_viking_1.png",
          getUnlockDays("Wikinger 1", grp),
          LinearGradient(colors: [backgroundBase, backGroundViking])),
      UnlockableBackground(
          "Ozean 1",
          "assets/illustrations/mascot_${mascotId}_ocean_2.png",
          getUnlockDays("Ozean 1", grp),
          LinearGradient(colors: [backgroundBase, backgroundOcean])),
      UnlockableBackground(
          "Pyramiden 2",
          "assets/illustrations/mascot_${mascotId}_pyramid_2.png",
          getUnlockDays("Pyramiden 2", grp),
          LinearGradient(colors: [backgroundBase, backgroundPyramid])),
      UnlockableBackground(
          "Weltraum 2",
          "assets/illustrations/mascot_${mascotId}_space_2.png",
          getUnlockDays("Weltraum 2", grp),
          LinearGradient(colors: [backgroundBase, backgroundSpace])),
      UnlockableBackground(
          "Vulkan 2",
          "assets/illustrations/mascot_${mascotId}_vulcan_2.png",
          getUnlockDays("Vulkan 2", grp),
          LinearGradient(colors: [backgroundBase, backgroundVulcan])),
      UnlockableBackground(
          "Wikinger 2",
          "assets/illustrations/mascot_${mascotId}_viking_2.png",
          getUnlockDays("Wikinger 2", grp),
          LinearGradient(colors: [backgroundBase, backGroundViking])),
      UnlockableBackground(
          "Zauberei 2",
          "assets/illustrations/mascot_${mascotId}_wizard_2.png",
          getUnlockDays("Zauberei 2", grp),
          LinearGradient(colors: [backgroundBase, backgroundWizard])),
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

  onMorningAssessment() async {
    int points = pointsForMorningAssessment + streakDays;
    await addPoints(points);
    await addDaysActive(1);
  }

  onFinalTask() async {
    await addPoints(10);
  }

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

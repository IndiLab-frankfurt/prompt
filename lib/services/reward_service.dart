import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prompt/models/unlockable_background.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/shared/ui_helper.dart';

class RewardService {
  late StreamController<int> controller = StreamController.broadcast();
  int scoreValue = 0;
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

  final List<int> pendingRewardNotifications = [];

  LinearGradient backgroundColor = LinearGradient(
    colors: UIHelper.baseGradientColors,
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
      if (colors.isEmpty) {
        colors = UIHelper.baseGradientColors;
      }

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
      "Monster": 0,
      "Flugzeug": 25,
      "Weltraum 1": 50,
      "Pyramiden 1": 75,
      "Vulkan 1": 100,
      "Wikinger 1": 125,
      "Ozean 1": 150,
      "Pyramiden 2": 175,
      "Zauberei 1": 200,
      "Weltraum 2": 225,
      "Vulkan 2": 250,
      "Ozean 2": 275,
      "Wikinger 2": 300,
      "Zauberei 2": 325
    };
    if (unlockDays.containsKey(background)) {
      return unlockDays[background];
    }
    return 0;
  }

  getBackgroundImages(String mascotId) {
    var grp = _dataService.getUserDataCache().group;
    return [
      UnlockableBackground(
          "Monster",
          "assets/illustrations/mascot_${mascotId}_bare.png",
          0,
          LinearGradient(
              colors: [UIHelper.bgGradientStart, UIHelper.bgGradientEnd])),
      UnlockableBackground(
          "Flugzeug",
          "assets/illustrations/mascot_${mascotId}_plane_2.png",
          25,
          LinearGradient(colors: [backgroundBase, backgroundPlane])),
      UnlockableBackground(
          "Weltraum 1",
          "assets/illustrations/mascot_${mascotId}_space_1.png",
          50,
          LinearGradient(colors: [backgroundBase, backgroundSpace])),
      UnlockableBackground(
          "Vulkan 1",
          "assets/illustrations/mascot_${mascotId}_vulcan_1.png",
          75,
          LinearGradient(colors: [backgroundBase, backgroundVulcan])),
      UnlockableBackground(
          "Pyramiden 1",
          "assets/illustrations/mascot_${mascotId}_pyramid_1.png",
          100,
          LinearGradient(colors: [backgroundBase, backgroundPyramid])),
      UnlockableBackground(
          "Wikinger 1",
          "assets/illustrations/mascot_${mascotId}_viking_1.png",
          125,
          LinearGradient(colors: [backgroundBase, backGroundViking])),
      UnlockableBackground(
          "Ozean 1",
          "assets/illustrations/mascot_${mascotId}_ocean_2.png",
          150,
          LinearGradient(colors: [backgroundBase, backgroundOcean])),
      UnlockableBackground(
          "Pyramiden 2",
          "assets/illustrations/mascot_${mascotId}_pyramid_2.png",
          175,
          LinearGradient(colors: [backgroundBase, backgroundPyramid])),
      UnlockableBackground(
          "Weltraum 2",
          "assets/illustrations/mascot_${mascotId}_space_2.png",
          200,
          LinearGradient(colors: [backgroundBase, backgroundSpace])),
      UnlockableBackground(
          "Vulkan 2",
          "assets/illustrations/mascot_${mascotId}_vulcan_2.png",
          225,
          LinearGradient(colors: [backgroundBase, backgroundVulcan])),
      UnlockableBackground(
          "Wikinger 2",
          "assets/illustrations/mascot_${mascotId}_viking_2.png",
          250,
          LinearGradient(colors: [backgroundBase, backGroundViking])),
      UnlockableBackground(
          "Zauberei 2",
          "assets/illustrations/mascot_${mascotId}_wizard_2.png",
          275,
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

  Future addPoints(int points) async {
    scoreValue += points;
    controller.add(scoreValue);
    pendingRewardNotifications.add(points);
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

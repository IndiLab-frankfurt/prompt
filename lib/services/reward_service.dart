import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prompt/models/unlockable_background.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/dialog_service.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/logging_service.dart';

class RewardService {
  RewardService(this._dataService, this._logService, this._dialogService);

  late StreamController<int> controller = StreamController.broadcast();
  int scoreValue = 0;
  int gems = 0;
  int streakDays = 0;
  static const int MAX_SCORE = 1290;
  static final pointsForMorningAssessment = 10;
  // final Color backgroundBase = Color(0xFFFFF3E0);
  final Color backgroundBase = Color(0xFFE6F0F6);
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
  List<int> scheduledRewards = [];
  late LinearGradient backgroundColor = LinearGradient(
    colors: [backgroundBase, backgroundBase],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final DataService _dataService;
  final LoggingService _logService;
  final DialogService _dialogService;

  final Map<String, int> unlockValues = {
    "Monster": 0,
    "Flugzeug": 10,
    "Weltraum 1": 40,
    "Pyramiden 1": 100,
    "Vulkan 1": 170,
    "Wikinger 1": 300,
    "Vulkan 2": 400,
    "Ozean 1": 810,
    "Pyramiden 2": 660,
    "Zauberei 1": 1260,
    "Weltraum 2": 1000,
    "Ozean 2": 1200,
    "Wikinger 2": 1290,
    "Zauberei 2": 1260,
  };

  double getRewardProgress(int val) {
    var prevStep = 0;

    var values = unlockValues.values.toList();
    values.sort();

    if (val == 0) return 0;

    for (var i = 0; i < values.length; i++) {
      var current = values[i];

      // if prev_step is higher than val, then this step is unlocked
      // otherwise, the next step is the one that is unlocked next
      if (val < current) {
        var prevPercentage = i / unlockValues.length;
        var nextPercentage = (i + 1) / unlockValues.length;
        // return linear interpolation between previous and current step
        return prevPercentage +
            (val - prevStep) /
                (current - prevStep) *
                (nextPercentage - prevPercentage);
      }

      prevStep = current;
    }

    return 1;
  }

  List<UnlockableBackground> get backgrounds {
    return getBackgroundImages(_selectedMascot);
  }

  Future retrieveScore() async {
    await _dataService.getScore().then((s) {
      scoreValue = s;
      controller.add(s);
      return s;
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
      if (colors != null) {
        var bgColor = LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );

        this.backgroundColor = bgColor;

        return colors;
      }
    });
    return backgroundColor.colors;
  }

  Future initialize() async {
    await getBackgroundColors();
    await getBackgroundImagePath();
    await retrieveScore();
  }

  getUnlockDays(String background) {
    if (unlockValues.containsKey(background)) {
      return unlockValues[background];
    }

    return 0;
  }

  getBackgroundImages(String mascotId) {
    return [
      UnlockableBackground(
          "Monster",
          "assets/illustrations/mascot_${mascotId}_bare.png",
          getUnlockDays("Monster"),
          LinearGradient(colors: [backgroundBase, backgroundBase])),
      UnlockableBackground(
          "Flugzeug",
          "assets/illustrations/mascot_${mascotId}_plane_2.png",
          getUnlockDays("Flugzeug"),
          LinearGradient(colors: [backgroundBase, backgroundPlane])),
      UnlockableBackground(
          "Weltraum 1",
          "assets/illustrations/mascot_${mascotId}_space_1.png",
          getUnlockDays("Weltraum 1"),
          LinearGradient(colors: [backgroundBase, backgroundSpace])),
      UnlockableBackground(
          "Vulkan 1",
          "assets/illustrations/mascot_${mascotId}_vulcan_1.png",
          getUnlockDays("Vulkan 1"),
          LinearGradient(colors: [backgroundBase, backgroundVulcan])),
      UnlockableBackground(
          "Pyramiden 1",
          "assets/illustrations/mascot_${mascotId}_pyramid_1.png",
          getUnlockDays("Pyramiden 1"),
          LinearGradient(colors: [backgroundBase, backgroundPyramid])),
      UnlockableBackground(
          "Wikinger 1",
          "assets/illustrations/mascot_${mascotId}_viking_1.png",
          getUnlockDays("Wikinger 1"),
          LinearGradient(colors: [backgroundBase, backGroundViking])),
      UnlockableBackground(
          "Ozean 1",
          "assets/illustrations/mascot_${mascotId}_ocean_2.png",
          getUnlockDays("Ozean 1"),
          LinearGradient(colors: [backgroundBase, backgroundOcean])),
      UnlockableBackground(
          "Pyramiden 2",
          "assets/illustrations/mascot_${mascotId}_pyramid_2.png",
          getUnlockDays("Pyramiden 2"),
          LinearGradient(colors: [backgroundBase, backgroundPyramid])),
      UnlockableBackground(
          "Weltraum 2",
          "assets/illustrations/mascot_${mascotId}_space_2.png",
          getUnlockDays("Weltraum 2"),
          LinearGradient(colors: [backgroundBase, backgroundSpace])),
      UnlockableBackground(
          "Vulkan 2",
          "assets/illustrations/mascot_${mascotId}_vulcan_2.png",
          getUnlockDays("Vulkan 2"),
          LinearGradient(colors: [backgroundBase, backgroundVulcan])),
      UnlockableBackground(
          "Wikinger 2",
          "assets/illustrations/mascot_${mascotId}_viking_2.png",
          getUnlockDays("Wikinger 2"),
          LinearGradient(colors: [backgroundBase, backGroundViking])),
      UnlockableBackground(
          "Zauberei 2",
          "assets/illustrations/mascot_${mascotId}_wizard_2.png",
          getUnlockDays("Zauberei 2"),
          LinearGradient(colors: [backgroundBase, backgroundWizard])),
    ];
  }

  setBackgroundImagePath(String imagePath) async {
    this.backgroundImagePath = imagePath;
    _logService.logEvent("backgroundImageChanged", data: imagePath);
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

  Future<void> addPoints(int points) async {
    scoreValue += points;
    controller.add(scoreValue);

    await locator<DialogService>()
        .showRewardDialog(title: "", score: scoreValue);
  }
}

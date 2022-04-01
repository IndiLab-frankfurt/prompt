import 'package:prompt/models/selectable.dart';
import 'package:prompt/shared/app_asset_paths.dart';

var outcomes = <Selectable>[
  Selectable(
      name: "Stolz anderer",
      description:
          "Dann sind andere Personen (z.B. meine Eltern) stolz auf mich.",
      iconPath: AppAssetPaths.ICON_MATH),
  Selectable(
      name: "Mein Stolz",
      description: "Dann bin ich selbst stolz auf mich.",
      iconPath: AppAssetPaths.ICON_MEHAPPY),
  Selectable(
      name: "Kommunikation",
      description:
          "Dann kann ich mich besser mit anderen Menschen verständigen.",
      iconPath: AppAssetPaths.ICON_USER),
  Selectable(
      name: "Lieder",
      description: "Dann kann ich meine Lieblingslieder besser verstehen.",
      iconPath: AppAssetPaths.ICON_MUSICNOTE),
  Selectable(
      name: "Videospiele",
      description: "Dann kann ich meine Videospiele besser verstehen.",
      iconPath: AppAssetPaths.ICON_GAMEPAD),
  Selectable(
      name: "Job",
      description:
          "Dann kriege ich einen besseren Job, wenn ich mit der Schule fertig bin.",
      iconPath: AppAssetPaths.ICON_TEAMWORK),
];

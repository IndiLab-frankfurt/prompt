import 'package:prompt/models/selectable.dart';
import 'package:prompt/shared/app_asset_paths.dart';

var obstacles = <Selectable>[
  Selectable(
      name: "Überforderung",
      description: "Das Vokabellernen fällt mir sehr schwer.",
      iconPath: AppAssetPaths.ICON_MATH),
  Selectable(
      name: "Konzentration",
      description: "Ich kann mich nicht auf das Vokabellernen konzentrieren.",
      iconPath: AppAssetPaths.ICON_BRAIN),
  Selectable(
      name: "Lustlosigkeit",
      description: "Ich habe keine Lust, Vokabeln zu lernen.",
      iconPath: AppAssetPaths.ICON_COMPUTER),
  Selectable(
      name: "Ablenkungen",
      description: "Ich habe keine Zeit, Vokabeln zu lernen.",
      iconPath: AppAssetPaths.ICON_EDUCATION),
  Selectable(
      name: "Vergessen",
      description: "Ich vergesse, dass ich Vokabeln lernen sollte.",
      iconPath: AppAssetPaths.ICON_ANATOMY),
  Selectable(
      name: "Multitasking",
      description:
          "Ich mache beim Vokabellernen andere Sachen (z.B. Fernsehen).",
      iconPath: AppAssetPaths.ICON_TEACHER),
];

import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/prompt_appbar.dart';

class DataPrivacyScreen extends StatelessWidget {
  const DataPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PromptAppBar(showBackButton: true),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          Text(
            "Die Datenschutzbestimmungen/Privacy Policy zur PROMPT-APP bei Studienteilnahme",
            style: Theme.of(context).textTheme.headline5,
          ),
          UIHelper.verticalSpaceMedium,
          Text(
            "Wozu wird die App PROMPT entwickelt?",
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            "Im Projekt PROMPT erarbeiten unter der Leitung von Dr. Jasmin Breitwieser und Prof. Dr. Garvin Brod Wissenschaftler*innen aus der Abteilung „Bildung und Entwicklung“ des DIPF | Leibniz-Institut für Bildungsforschung und Bildungsinformation in Zusammenarbeit mit dem Arbeitsbereich Educational Technologies am Informationszentrum Bildung des DIPF eine Lernplan-App.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "Die App unterstützt Kinder dabei, ihre digitalen Lernzeiten selbst zu planen und ihre Lernfortschritte zu vergrößern. Dabei wird untersucht, welche Methoden und Features eine solche App besonders erfolgreich machen.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
              "Unsere Datenschutzbestimmungen in Bezug auf die Nutzung der App PROMPT")
        ]),
      ),
    );
  }
}

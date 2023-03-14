import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';

class DataPrivacyInfo extends StatelessWidget {
  const DataPrivacyInfo({super.key});

  static List<Widget> getConsentText(BuildContext context) {
    return [
      Text(
        "Die Datenschutzbestimmungen/Privacy Policy zur PROMPT-ADAPT App bei Studienteilnahme",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      UIHelper.verticalSpaceMedium,
      Text(
        "Wozu wird die App PROMPT-ADAPT entwickelt?",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      UIHelper.verticalSpaceMedium,
      Text(
        "Im Projekt PROMPT erarbeiten unter der Leitung von Dr. Jasmin Breitwieser und Prof. Dr. Garvin Brod Wissenschaftler*innen aus der Abteilung „Bildung und Entwicklung“ des DIPF | Leibniz-Institut für Bildungsforschung und Bildungsinformation in Zusammenarbeit mit dem Arbeitsbereich Educational Technologies am Informationszentrum Bildung des DIPF eine Lernplan-App. Die App unterstützt Kinder dabei, ihre digitalen Lernzeiten selbst zu planen und ihre Lernfortschritte zu vergrößern. Dabei wird untersucht, welche Methoden und Features eine solche App besonders erfolgreich machen.",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      UIHelper.verticalSpaceMedium,
      Text(
        "Unsere Datenschutzbestimmungen in Bezug auf die Nutzung der App PROMPT-ADAPT",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      UIHelper.verticalSpaceMedium,
      Text(
          "Mit Hilfe der App PROMPT-ADAPT erheben wir Daten, indem wir Ihrem Kind direkt Fragen zu seinem Lernverhalten, seinen Vorerfahrungen mit digitalen Medien sowie Feedback zur App stellen. Die Dateneingabe funktioniert über ein Formular in der App. Dabei erfasst die App auch, wann Ihr Kind die Fragen beantwortet. Die App erhebt aber zu keiner Zeit Daten, die Rückschlüsse auf die Identität der Nutzenden erlauben. Nutzende entsperren die App mit einem Code und Passwort, die mit Angaben aus einem Onlinefragebogen verknüpft werden können. Die Daten aus dem Onlinefragebogen werden über einen verschlüsselten Dateiserver ausschließlich an die Studienleitung weitergeleitet und von ihr pseudonymisiert. Pseudonymisierung bedeutet, dass die Studienleitung Ihre personenbezogenen Daten und die Ihres Kindes mit einer Codenummer versieht, sodass keine Namen oder Initialen verwendet werden. Auf den Codeschlüssel, der es erlaubt, die studienbezogenen Daten mit Ihnen in Verbindung zu bringen, hat nur die Studienleitung Zugriff. Nach Ablauf von 24 Monaten wird die Rekodierliste gelöscht, sodass Ihre Daten von diesem Zeitpunkt an anonymisiert sind. Unsere Arbeit folgt streng den Bestimmungen des Datenschutzes. Die im Rahmen der Studie erbetenen Angaben unterliegen der Schweigepflicht und werden unter Wahrung der Bestimmungen der europäischen Datenschutz-Grundverordnung (DSGVO) gespeichert und wissenschaftlich ausgewertet.  Die Speicherung der durch die App PROMPT-ADAPT erhobenen Daten erfolgt während der Erhebungszeit auf in der EU gehosteten Servern und anschließend auf firewallgeschützten Servern des DIPF. Die Weitergabe personenbezogener Daten an Dritte erfolgt nicht. Die Daten werden ausschließlich zu Forschungszwecken verwendet. Eine eventuelle Weitergabe von nichtpersonenbezogenen Studiendaten erfolgt ausschließlich in anonymisierter Form. Die anonymisierten Daten werden im Sinne der Regeln guter wissenschaftlicher Praxis der Deutschen Forschungsgemeinschaft mindestens 10 Jahre an unserem Institut aufbewahrt. Ihr Einverständnis vorausgesetzt werden die anonymisierten Daten außerdem an ein professionelles wissenschaftliches Repositorium weitergegeben.")
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Scrollbar(
        thumbVisibility: true,
        child: ListView(children: getConsentText(context)),
      ),
    );
  }
}

# prompt

Project for the Flutter App of the [PROMPT research project](https://indilearn.de/en/projects-individualized-support/project-prompt/)

![Promo Screenshot of the PROMPT App](/assets/screenshots/ScreenshotPromo_1.png)

# Architecture

The app uses a MVVM architecture with [Provider](https://pub.dev/packages/provider) for the state logic in the ViewModels, and [get_it](https://pub.dev/packages/get_it) for service location.  

# Building

In order to build this project, clone the repository and run

``flutter run``

To generate the data classes for the JSON files, run

``flutter pub run build_runner build``

Localized strings are in the /lib/l10n directory. To generate the l10n classes, run

``flutter gen-l10n``

# Backend

Since the version for study 3, the backend of this project is written in Django and is available at https://github.com/Dabieder/prompt_backend

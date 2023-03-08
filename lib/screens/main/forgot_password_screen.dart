import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/prompt_appbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PromptAppBar(showBackButton: true),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          Text(
            "Hast du dein Passwort oder deinen Benutzernamen vergessen?",
            style: Theme.of(context).textTheme.headline5,
          ),
          UIHelper.verticalSpaceMedium,
          Text(
            "Kein Problem! Schreibe einfach eine Mail an prompt@dipf-institut.de und wir helfen dir gerne weiter.",
            style: Theme.of(context).textTheme.headline6,
          ),
        ]),
      ),
    );
  }
}

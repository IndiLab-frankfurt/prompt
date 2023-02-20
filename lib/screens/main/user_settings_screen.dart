import 'package:flutter/material.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/widgets/prompt_appbar.dart';

class UserSettingsScreen extends StatelessWidget {
  late final SettingsService _settingsService = locator.get<SettingsService>();
  UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var settingsKeys = SettingsKeys.values;
    return Scaffold(
        appBar: PromptAppBar(
          title: "Einstellungen",
          showBackButton: true,
        ),
        body: Container(
            child: ListView.builder(
                itemCount: settingsKeys.length,
                itemBuilder: (context, index) {
                  return buildSettingsItem(context, index);
                })));
  }

  Widget buildSettingsItem(BuildContext context, int index) {
    return Container(
      child: Text("Test"),
    );
  }
}

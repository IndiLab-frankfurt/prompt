import 'package:flutter/material.dart';
import 'package:prompt/widgets/data_privacy_info.dart';
import 'package:prompt/widgets/prompt_appbar.dart';

class DataPrivacyScreen extends StatelessWidget {
  const DataPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PromptAppBar(showBackButton: true),
      body: DataPrivacyInfo(),
    );
  }
}

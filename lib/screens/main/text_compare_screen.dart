import 'package:flutter/material.dart';
import 'package:prompt/widgets/prompt_appbar.dart';

class TextCompareScreen extends StatelessWidget {
  const TextCompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Screen to compare the different text styles at a glance
    // Listview with a lot of texts that each have a different defaultTextStyle
    return Scaffold(
        appBar: PromptAppBar(
          showBackButton: true,
        ),
        body: Container(
          child: ListView(children: [
            Text("Body Large", style: Theme.of(context).textTheme.bodyLarge),
            Text("Body Medium", style: Theme.of(context).textTheme.bodyMedium),
            Text("Body Small", style: Theme.of(context).textTheme.bodySmall),
            Text("Display Large",
                style: Theme.of(context).textTheme.displayLarge),
            Text("Display Medium",
                style: Theme.of(context).textTheme.displayMedium),
            Text("Display Small",
                style: Theme.of(context).textTheme.displaySmall),
            Text("Headline Large",
                style: Theme.of(context).textTheme.headlineLarge),
            Text("Headline Medium",
                style: Theme.of(context).textTheme.headlineMedium),
            Text("Headline Small",
                style: Theme.of(context).textTheme.headlineSmall),
            Text("Title Large", style: Theme.of(context).textTheme.titleLarge),
            Text("Title Medium",
                style: Theme.of(context).textTheme.titleMedium),
            Text("Title Small", style: Theme.of(context).textTheme.titleSmall),
            Text("Label Large", style: Theme.of(context).textTheme.labelLarge),
            Text("Label Small", style: Theme.of(context).textTheme.labelSmall),
          ]),
        ));
  }
}

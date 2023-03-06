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
            Text("BodyText1", style: Theme.of(context).textTheme.bodyText1),
            Text("BodyText2", style: Theme.of(context).textTheme.bodyText2),
            Text("Headline1", style: Theme.of(context).textTheme.headline1),
            Text("Headline2", style: Theme.of(context).textTheme.headline2),
            Text("Headline3", style: Theme.of(context).textTheme.headline3),
            Text("Headline4", style: Theme.of(context).textTheme.headline4),
            Text("Headline5", style: Theme.of(context).textTheme.headline5),
            Text("Headline6", style: Theme.of(context).textTheme.headline6),
            Text("Subtitle1", style: Theme.of(context).textTheme.subtitle1),
            Text("Subtitle2", style: Theme.of(context).textTheme.subtitle2),
            Text("Button", style: Theme.of(context).textTheme.button),
            Text("Caption", style: Theme.of(context).textTheme.caption),
            Text("Overline", style: Theme.of(context).textTheme.overline),
          ]),
        ));
  }
}

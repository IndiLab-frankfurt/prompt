import 'package:flutter/material.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/widgets/prompt_appbar.dart';

class ScreenSelectionScreen extends StatelessWidget {
  final List<AppScreen> routes = AppScreen.values;
  const ScreenSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PromptAppBar(showBackButton: true),
      body: buildList(context),
    );
  }

  Widget buildList(BuildContext context) {
    return ListView.separated(
      itemCount: routes.length,
      itemBuilder: (context, index) {
        final route = routes[index];
        return ListTile(
          leading: Icon(Icons.pages),
          title: Text(route.name),
          onTap: () {
            Navigator.pushNamed(context, route.name);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}

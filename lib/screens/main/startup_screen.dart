import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prompt/viewmodels/startup_view_model.dart';

class StartupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => StartupViewModel(),
        lazy: false,
        child: Scaffold(
            body:
                Container(child: Center(child: CircularProgressIndicator()))));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prompt/screens/splash_screen.dart';
import 'package:prompt/viewmodels/startup_view_model.dart';

class StartupScreen extends StatefulWidget {
  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  buildWaitingIndicator() {
    return SplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return ChangeNotifierProvider(
        create: (_) => StartupViewModel(), lazy: false, child: SplashScreen());
  }
}

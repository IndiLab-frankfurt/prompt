import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/screens/startup_screen.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setupAwesomeNotifications();
  runApp(MyApp());
}

void setupAwesomeNotifications() {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/ic_notification',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
}

class MyApp extends StatelessWidget {
  buildMaterialApp(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Serene',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.white,
        selectedRowColor: Colors.orange[200],
        // textTheme: TextTheme(
        //   bodyText1: GoogleFonts.andikaNewBasic(fontSize: 15),
        //   bodyText2: GoogleFonts.andikaNewBasic(
        //       fontSize: 15, fontWeight: FontWeight.w700),
        //   subtitle1: GoogleFonts.andikaNewBasic(
        //       fontSize: 20, fontWeight: FontWeight.w600),
        // ),
        textTheme: GoogleFonts.andikaNewBasicTextTheme(
          Theme.of(context).textTheme,
        ),
        // GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        iconTheme: IconThemeData(color: Colors.black),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
        //     .copyWith(secondary: Color(0xfff96d15))
      ),
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: StartupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    locator<ExperimentService>().reactToNotifications(context);

    return buildMaterialApp(context);
  }
}

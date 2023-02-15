import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_router.dart';

import 'screens/main/startup_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'prompt-942ca',
      options: FirebaseOptions(
          apiKey: "AIzaSyAPqtpv-07sGIT7rPVVKYJ0nKmvB-zPpV4",
          appId: "1:972973871566:web:207f4b7287a6bdd95b9b9f",
          messagingSenderId: "972973871566",
          projectId: "prompt-942ca"));
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  buildMaterialApp(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prompt',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.orange[50],
          canvasColor: Colors.white,
          selectedRowColor: Colors.orange[200],
          textTheme: TextTheme(
            bodyText1: GoogleFonts.quicksand(fontSize: 15),
            bodyText2: GoogleFonts.quicksand(
                fontSize: 15, fontWeight: FontWeight.w700),
            subtitle1: GoogleFonts.quicksand(
                fontSize: 20, fontWeight: FontWeight.w600),
          ),
          buttonTheme: ButtonThemeData(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
          iconTheme: IconThemeData(color: Colors.black),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
              .copyWith(secondary: Color(0xfff96d15))),
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: StartupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(context);
  }
}

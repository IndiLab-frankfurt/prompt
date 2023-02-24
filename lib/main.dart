import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_router.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('de'), // German
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.lightBlue,
        scaffoldBackgroundColor: UIHelper.bgGradientStart,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.quicksand(fontSize: 15),
          bodyText2:
              GoogleFonts.quicksand(fontSize: 15, fontWeight: FontWeight.w700),
          subtitle1:
              GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.w600),
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
      ),
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

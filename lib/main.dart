import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prompt/managers/dialog_manager.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_router.dart';
import 'screens/main/startup_screen.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  buildMaterialApp(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prompt',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.lightBlue,
        // textTheme: GoogleFonts.comicNeueTextTheme(Theme.of(context).textTheme)
        //     .apply(fontSizeFactor: 1.0),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.comicNeue(fontSize: 18),
          bodyMedium:
              GoogleFonts.comicNeue(fontSize: 18, fontWeight: FontWeight.w500),
          titleMedium:
              GoogleFonts.comicNeue(fontSize: 20, fontWeight: FontWeight.w600),
          bodySmall: GoogleFonts.comicNeue(fontSize: 16),
          displayLarge: GoogleFonts.comicNeue(fontSize: 40),
          displayMedium: GoogleFonts.comicNeue(fontSize: 35),
          displaySmall: GoogleFonts.comicNeue(fontSize: 30),
          headlineLarge: GoogleFonts.comicNeue(fontSize: 40),
          headlineMedium: GoogleFonts.comicNeue(fontSize: 35),
          headlineSmall: GoogleFonts.comicNeue(fontSize: 30),
          titleLarge: GoogleFonts.comicNeue(fontSize: 30),
          titleSmall: GoogleFonts.comicNeue(fontSize: 20),
          labelLarge: GoogleFonts.comicNeue(fontSize: 20),
          labelSmall: GoogleFonts.comicNeue(fontSize: 15),
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
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(
            child: widget!,
          ),
        ),
      ),
      home: StartupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(context);
  }
}

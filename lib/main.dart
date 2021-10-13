import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/screens/startup_screen.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_router.dart';

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
      // debugShowMaterialGrid: true,
      title: 'Serene',
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
          // GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
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
      // initialRoute: initialRoute,
      // routes: Router.getRoutes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(context);
  }
}

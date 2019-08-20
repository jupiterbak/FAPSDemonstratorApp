import 'package:flutter/material.dart';
import 'package:faps_demonstrator_customer_app/views/HomeScreen.dart';
import 'package:faps_demonstrator_customer_app/views/SplashScreen.dart';
import 'package:faps_demonstrator_customer_app/views/NewOrderScreen.dart';

void main() => runApp(FAPSDemonstratorApp());

class FAPSDemonstratorApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color faps_green = const Color.fromARGB(255, 151, 193, 57);
//    Color faps_green_dark = const Color.fromARGB(255, 70, 89, 26);
//    Color faps_orange = const Color.fromARGB(255, 229, 115, 0);
//    Color faps_blue_dark = const Color.fromARGB(255, 31, 73, 110);
//    Color faps_blue = const Color.fromARGB(255, 104, 161, 213);

    return MaterialApp(
      title: 'FAPS Demonstrator Customer',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryTextTheme: TextTheme(
            title: TextStyle(
                color: Colors.white
            ),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        accentIconTheme: new IconThemeData(color: Colors.white),
        fontFamily: 'Roboto',
        primaryColor: faps_green,
        accentColor: faps_green,
      ),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      supportedLocales: [
        const Locale("en", "US"),
        const Locale("de", "DE"),
      ],
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        HomeScreen.routeName: (BuildContext context) => Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: Container(child: new HomeScreen(title: 'FAPS Customer Apps'))),
          ),
        ),
        NewOrderScreen.routeName: (BuildContext context) => NewOrderScreen(),
      },
    );
  }
}
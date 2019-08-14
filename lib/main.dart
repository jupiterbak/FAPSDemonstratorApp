import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'SplashScreen.dart';
import 'NewOrderScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color faps_green = const Color.fromARGB(255, 151, 193, 57);
    Color faps_orange = const Color.fromARGB(255, 229, 115, 0);
    Color faps_blue_dark = const Color.fromARGB(255, 31, 73, 110);
    Color faps_blue = const Color.fromARGB(255, 104, 161, 213);

    return MaterialApp(
      title: 'FAPS Demonstrator Customer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        primaryColor: faps_green,
        accentColor: faps_green,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        HomeScreen.routeName: (BuildContext context) => new HomeScreen(title: 'FAPS Customer Apps'),
        NewOrderScreen.routeName: (BuildContext context) => NewOrderScreen(),
      },
    );
  }
}
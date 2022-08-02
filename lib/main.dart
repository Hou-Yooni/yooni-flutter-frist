import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/views/auth/landing_customer_screen.dart';

const MaterialColor yellowColor = MaterialColor(
  0xFFFDD835,
  <int, Color>{
    50: Color(0xFFFFFDE7),
    100: Color(0xFFFFFDE7),
    200: Color(0xFFFFFDE7),
    300: Color(0xFFFFF9C4),
    400: Color(0xFFFFF59D),
    500: Color(0xFFFFF176),
    600: Color(0xFFFFEE58),
    700: Color(0xFFFDD835),
    800: Color(0xFFFBC02D),
    900: Color(0xFFF9A825),
  },
);

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //如果 Flutter 需要在調用 runApp 之前調用原生代碼都 需要加上這一行。
  // ignore: avoid_print
  await Firebase.initializeApp().then((value) => print('Firebase initialized'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: yellowColor, fontFamily: 'Dosis-Regular'),
        home: LandingCustomerScreen());
  }
}

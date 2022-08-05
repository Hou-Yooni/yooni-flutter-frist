import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/views/customer_home_screen.dart';

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
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Dosis-Regular'),
      home: const CustomerHomeScreen(),
    );
  }
}

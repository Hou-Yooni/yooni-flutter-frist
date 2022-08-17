// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/views/auth/landing_customer_screen.dart';
import 'package:flutter_project/views/auth/landing_seller_screen.dart';
import 'package:flutter_project/views/auth/seller_login_screen.dart';
import 'package:flutter_project/views/customer_home_screen.dart';
import 'package:flutter_project/views/seller_home_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //如果 Flutter 需要在調用 runApp 之前調用原生代碼都 需要加上這一行。
  // ignore: avoid_print
  await Firebase.initializeApp().then((value) => print('Firebase initialized'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color.fromARGB(255, 235, 194, 80),
            ),
        fontFamily: 'Dosis-Regular',
      ),
      initialRoute: SellerLoginScreen.routeName,
      routes: {
        CustomerHomeScreen.routeName: (context) => const CustomerHomeScreen(),
        LandingCustomerScreen.routeName: (context) => LandingCustomerScreen(),
        LandingSellerScreen.routeName: (context) => LandingSellerScreen(),
        SellerLoginScreen.routeName: (context) => SellerLoginScreen(),
        SellerHomeScreen.routeName: (context) => SellerHomeScreen(),
      },
    );
  }
}

// ignore_for_file: avoid_print, use_build_context_synchronously, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/snack_bar_controllers.dart';
import 'package:flutter_project/views/auth/landing_seller_screen.dart';
import 'package:flutter_project/views/seller_home_screen.dart';

import 'landing_customer_screen.dart';

// ignore: use_key_in_widget_constructors
class SellerLoginScreen extends StatefulWidget {
  static const String routeName = 'SellerLoginScreen';

  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  late String email;
  late String password;
  bool isLoading = false;

  loginSeller() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        await _auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
        return Navigator.of(context).pushNamedAndRemoveUntil(
            SellerHomeScreen.routeName, (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
        return snackBar('Please Field most not be empty', context);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      return snackBar(e.code, context);
    }
  }

  //user登入

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sign in to Seller's Account",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Dosis-Bold',
                          fontStyle: FontStyle.italic),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        size: 35,
                        color: Color.fromARGB(255, 235, 194, 80),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: passwordVisible
                              ? const Icon(
                                  Icons.visibility_off,
                                )
                              : const Icon(
                                  Icons.visibility,
                                ),
                        ),
                        labelText: 'Password',
                        hintText: 'Enter your Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // ignore: sized_box_for_whitespace
                    GestureDetector(
                      onTap: () {
                        loginSeller();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 194, 80),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Need an account?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LandingCustomerScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sing up',
                            style: TextStyle(
                              color: Color.fromARGB(255, 235, 194, 80),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Or',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Create a seller's Account?",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              LandingSellerScreen.routeName,
                            );
                          },
                          child: const Text(
                            'Sing up',
                            style: TextStyle(
                              color: Color.fromARGB(255, 235, 194, 80),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

// ignore_for_file: avoid_print, use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';

import '../../controllers/auth_controllers.dart';
import 'landing_customer_screen.dart';

// ignore: use_key_in_widget_constructors
class SellerLoginScreen extends StatefulWidget {
  static const String routeName = 'SellerLoginScreen';

  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
  final AuthController _authController = AuthController();

  bool passwordVisible = true;

  //user登入

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // ignore: sized_box_for_whitespace
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 235, 194, 80),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                        onPressed: () {},
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
    ));
  }
}
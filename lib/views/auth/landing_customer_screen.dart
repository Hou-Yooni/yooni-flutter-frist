// ignore_for_file: avoid_print, use_build_context_synchronously, unused_field

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_project/views/auth/customer_login_screen.dart';
import 'package:flutter_project/views/auth/landing_seller_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/auth_controllers.dart';
import '../../controllers/snack_bar_controllers.dart';

// ignore: use_key_in_widget_constructors
class LandingCustomerScreen extends StatefulWidget {
  static const String routeName = 'LandingCustomerScreen';
  @override
  State<LandingCustomerScreen> createState() => _LandingCustomerScreenState();
}

class _LandingCustomerScreenState extends State<LandingCustomerScreen> {
  final AuthController _authController = AuthController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;
  Uint8List? _image;

  // 開啟圖片庫
  pickImageFromGallery() async {
    Uint8List im = await _authController
        .pickImage(ImageSource.gallery); //用於從 Uint8List 獲取圖片
    setState(() {
      _image = im;
    });
  }

  // 開啟相機
  pickImageFromCamera() async {
    Uint8List im = await _authController
        .pickImage(ImageSource.camera); //用於從 Uint8List 獲取圖片
    setState(() {
      _image = im;
    });
  }

  // 註冊
  signUp() async {
    setState(() {
      isLoading = true;
    });
    String res = await _authController.signUpUsers(_fullNameController.text,
        _emailController.text, _passwordController.text, _image);
    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
      return snackBar(res, context);
    } else {
      return Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => CustomerLoginScreen()));
    }
  }

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
                    "Create Customer's Account",
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
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundColor:
                              const Color.fromARGB(255, 235, 194, 80),
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundColor: Color.fromARGB(255, 235, 194, 80),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 235, 194, 80),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            pickImageFromCamera();
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 235, 194, 80),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            pickImageFromGallery();
                          },
                          icon: const Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordController,
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
                    controller: _emailController,
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
                    onTap: () {
                      signUp();
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
                                color: Colors.white)
                            : const Text(
                                'Sign up',
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
                        'Aleady have an account?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CustomerLoginScreen(),
                          ));
                        },
                        child: const Text(
                          'Login',
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
                        onPressed: () {
                          Navigator.pushNamed(
                              context, LandingSellerScreen.routeName);
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
    ));
  }
}

// ignore_for_file: avoid_print, use_build_context_synchronously, unused_field, unused_local_variable, void_checks

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/snack_bar_controllers.dart';
import 'package:flutter_project/views/auth/landing_customer_screen.dart';
import 'package:flutter_project/views/auth/seller_login_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/auth_controllers.dart';

// ignore: use_key_in_widget_constructors
class LandingSellerScreen extends StatefulWidget {
  static const String routeName = 'LandingSellerScreen';
  @override
  State<LandingSellerScreen> createState() => _LandingSellerScreenState();
}

class _LandingSellerScreenState extends State<LandingSellerScreen> {
  final AuthController _authController = AuthController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String fullName;
  late String email;
  late String password;
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

  // 將圖片檔案上傳至Firebase Storage
  _uploadImageToStorage(Uint8List? image) async {
    Reference ref = _firebaseStorage.ref().child('profiles').child(fullName);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // 註冊
  void signUp() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        if (_image != null) {
          UserCredential cred =
              await _firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          String downloadUrl = await _uploadImageToStorage(_image);
          await _firestore.collection('sellers').doc(cred.user?.uid).set(
            {
              'sellerUid': cred.user!.uid,
              'storeName': fullName,
              'email': email,
              'address': '',
              'image': downloadUrl,
            },
          ).whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });

          //註冊成功後清理畫面上資料
          _formKey.currentState!.reset();
          setState(() {
            _image = null;
          });
        } else {
          return snackBar('Please Pick Image', context);
        }
      } else {
        return snackBar('Please Pick Image', context);
      }
    } catch (e) {
      print(e);
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Create Seller's Account",
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (String value) {
                        fullName = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else {
                          return null;
                        }
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
                      onChanged: (String value) {
                        password = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (String value) {
                        email = value;
                      },
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
                                  color: Colors.white,
                                )
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
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              SellerLoginScreen.routeName,
                            );
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Create a customer's Account?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
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

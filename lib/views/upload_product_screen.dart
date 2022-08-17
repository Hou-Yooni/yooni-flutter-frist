// ignore_for_file: use_key_in_widget_constructors, void_checks, avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/snack_bar_controllers.dart';
import 'package:flutter_project/utilities/category_list.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  String mainCategoryValue = 'Select Main Category';
  String subCategoryValue = 'subcategory';

  List<String> subCategoryList = [];

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;
  late String productId;
  List<XFile>? imageList = [];
  List<String> imageUrlList = [];

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );
      setState(() {
        imageList = pickedImages!;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget displayImages() {
    if (imageList!.isNotEmpty) {
      return InkWell(
        onTap: () {
          setState(() {
            imageList = null;
          });
        },
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageList!.length,
            itemBuilder: (context, index) {
              return Image.file(File(imageList![index].path));
            }),
      );
    } else {
      return const Center(
        child: Text(
          'You Have not \n \n Picked any Images',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      );
    }
  }

  void selectMainCategory(String? value) {
    if (value == 'men') {
      subCategoryList = men;
    } else if (value == 'women') {
      subCategoryList = women;
    }
    setState(() {
      mainCategoryValue = value!;
      subCategoryValue = 'subcategory';
    });
  }

  Future<void> uploadImages() async {
    if (mainCategoryValue != 'Select Main Category' &&
        subCategoryValue != 'subcategory') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imageList!.isNotEmpty) {
          try {
            for (var image in imageList!) {
              // 此處與會員上傳圖片地方不同(child方式) 以下是使用ref方式，兩者皆可
              // path.basename 獲取path最後一個分隔符之後的部分
              Reference ref =
                  _firebaseStorage.ref('products/${path.basename(image.path)}');

              await ref.putFile(File(image.path)).whenComplete(() async {
                String url = await ref.getDownloadURL();
                // await ref.getDownloadURL().then((url) {
                imageUrlList.add(url);
                // });
              });
            }
          } catch (e) {
            print(e);
          }

          // setState(() {
          //   imageList = [];
          // });
          // _formKey.currentState!.reset();
        } else {
          return snackBar('Please Pick images', context);
        }
      } else {
        return snackBar('Please Fields must must not be empty', context);
      }
    } else {
      return snackBar('Please Select Main Category', context);
    }
  }

  void uploadData() async {
    if (imageList!.isNotEmpty) {
      CollectionReference productRef =
          _firebaseFirestore.collection('products');
      productId = Uuid().v4();
      await productRef.doc(productId).set({
        'productId': productId,
        'mainCategory': mainCategoryValue,
        'subCategory': subCategoryValue,
        'price': price,
        'instoke': quantity,
        'productName': productName,
        'productDescription': productDescription,
        'sellerUid': FirebaseAuth.instance.currentUser!.uid,
        'productImages': imageUrlList,
        'discount': 0,
      }).whenComplete(() {
        setState(() {
          imageList = [];
          imageUrlList = [];
          subCategoryList = [];
          mainCategoryValue = 'Select Main Category';
        });
        _formKey.currentState!.reset();
      });
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() => uploadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: const Color.fromARGB(255, 224, 224, 224),
                        child: Center(
                          child: imageList != null
                              ? displayImages()
                              : const Text(
                                  'You Have not \n \n Picked any Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Select Main Category'),
                          DropdownButton(
                            borderRadius: BorderRadius.circular(15),
                            style: const TextStyle(color: Colors.black),
                            value: mainCategoryValue,
                            items:
                                maincategory.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              selectMainCategory(value);
                            },
                          ),
                          const Text('Select sub Category'),
                          DropdownButton(
                            borderRadius: BorderRadius.circular(15),
                            style: const TextStyle(color: Colors.black),
                            value: subCategoryValue,
                            items: subCategoryList
                                .map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                subCategoryValue = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: SizedBox(
                    height: 40,
                    child: Divider(
                      color: Color.fromARGB(255, 223, 223, 223),
                      thickness: 1.4,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Price must not be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Price',
                        hintText: 'Price',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onSaved: (value) {
                        price = double.parse(value!);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Quantity must not be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        hintText: 'Add Quantity',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onSaved: (value) {
                        quantity = int.parse(value!);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Product Name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        hintText: 'Enter Product Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onSaved: (value) {
                        productName = value!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Product Description must not be empty';
                        } else {
                          return null;
                        }
                      },
                      maxLength: 100,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Product Description',
                        hintText: 'Enter Product Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onSaved: (value) {
                        productDescription = value!;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              onPressed: () {
                pickProductImages();
              },
              backgroundColor: const Color.fromARGB(255, 235, 194, 80),
              child: const Icon(
                Icons.photo_library,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              uploadProduct();
            },
            backgroundColor: const Color.fromARGB(255, 235, 194, 80),
            child: const Icon(
              Icons.upload,
            ),
          ),
        ],
      ),
    );
  }
}

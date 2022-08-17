// ignore_for_file: use_key_in_widget_constructors, void_checks, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/snack_bar_controllers.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductScreen extends StatefulWidget {
  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String mainCategory = 'men';

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;
  List<XFile>? imageList = [];

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

  void uploadProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (imageList!.isNotEmpty) {
        print(price);
        print(quantity);

        setState(() {
          imageList = [];
        });
        _formKey.currentState!.reset();
      } else {
        return snackBar('Please Pick images', context);
      }
    } else {
      return snackBar('Please Fields must must not be empty', context);
    }
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.grey,
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
                    Column(
                      children: [
                        const Text('Select Main Category'),
                        DropdownButton(
                          value: mainCategory,
                          items: const [
                            DropdownMenuItem(value: 'men', child: Text('men')),
                            DropdownMenuItem(
                                value: 'women', child: Text('women')),
                            DropdownMenuItem(
                                value: 'kids', child: Text('kids')),
                            DropdownMenuItem(
                                value: 'shose', child: Text('shose')),
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              mainCategory = value!;
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                  child: Divider(
                    color: Color.fromARGB(255, 223, 223, 223),
                    thickness: 1.4,
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

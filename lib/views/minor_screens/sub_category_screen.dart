// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SubCategoryScreen extends StatelessWidget {
  final String subCategoryName;
  final String mainCcategory;

  const SubCategoryScreen(
      {super.key, required this.subCategoryName, required this.mainCcategory});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          subCategoryName,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(mainCcategory),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_project/views/category_screen.dart';
import 'package:flutter_project/views/dashboard_screen.dart';
import 'package:flutter_project/views/home_screen.dart';
import 'package:flutter_project/views/store_screen.dart';
import 'package:flutter_project/views/upload_product_screen.dart';

class SellerHomeScreen extends StatefulWidget {
  //靜態全局變量 靜態局部變量只會被初始化一次，下次使用依據上一次保存的值
  static const String routeName = 'SellerHomeScreen';
  const SellerHomeScreen({Key? key}) : super(key: key);

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  // ignore: prefer_final_fields
  int _selectedItem = 0;

  //列表集合資料
  final List<Widget> _page = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    DashboardScreen(),
    UploadProductScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 235, 194, 80),
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedItem,
        onTap: (index) {
          setState(() {
            _selectedItem = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          )
        ],
      ),
      body: _page[_selectedItem],
    );
  }
}

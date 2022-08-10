// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_project/views/cart_screen.dart';
import 'package:flutter_project/views/category_screen.dart';
import 'package:flutter_project/views/home_screen.dart';
import 'package:flutter_project/views/profile_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  //靜態全局變量 靜態局部變量只會被初始化一次，下次使用依據上一次保存的值
  static const String routeName = 'CustomerHomeScreen';
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  // ignore: prefer_final_fields
  int _selectedItem = 0;

  //列表集合資料
  final List<Widget> _page = [
    HomeScreen(),
    CategoryScreen(),
    Center(child: Text('Shop Screen')),
    CartScreen(),
    ProfileScreen(),
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
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
      body: _page[_selectedItem],
    );
  }
}

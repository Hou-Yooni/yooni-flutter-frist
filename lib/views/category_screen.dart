// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_project/views/categories/men_category_screen.dart';

// ignore: use_key_in_widget_constructors
class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();
  final List<ItemData> _item = [
    ItemData(categoryName: 'Men'),
    ItemData(categoryName: 'Women'),
    ItemData(categoryName: 'Kids'),
    ItemData(categoryName: 'Shose'),
    ItemData(categoryName: 'Bag'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.2,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      _pageController.jumpToPage(index);
                      // for (var element in _item) {
                      //   element.isSelected = false;
                      // }
                      // setState(() {
                      //   _item[index].isSelected = true;
                      // });
                    },
                    child: Container(
                      color: _item[index].isSelected
                          ? Colors.white
                          : Colors.grey.shade300,
                      height: 100,
                      child: Center(
                        child: Text(_item[index].categoryName),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.white,
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  for (var element in _item) {
                    element.isSelected = false;
                  }
                  setState(() {
                    _item[value].isSelected = true;
                  });
                },
                scrollDirection: Axis.vertical,
                children: [
                  MenCategoryScreen(),
                  const Center(
                    child: Text('Women'),
                  ),
                  const Center(
                    child: Text('Kids'),
                  ),
                  const Center(
                    child: Text('Shose'),
                  ),
                  const Center(
                    child: Text('Bag'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemData {
  String categoryName;
  bool isSelected;

  ItemData({required this.categoryName, this.isSelected = false});
}

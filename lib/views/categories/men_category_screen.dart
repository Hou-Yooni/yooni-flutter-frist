// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../utilities/category_list.dart';
import '../minor_screens/sub_category_screen.dart';

// ignore: must_be_immutable
class MenCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(
            'Men',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.68,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 60,
            children: List.generate(
              men.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SubCategoryScreen(
                            subCategoryName: men[index],
                            mainCcategory: 'Men',
                          );
                        },
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.asset(
                          'assets/images/men/men$index.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(men[index])
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'inner_screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const SearchScreen(),
              ),
            );
          },
          child: Container(
            height: 43,
            decoration: BoxDecoration(
              // color: Colors.amber,
              border: Border.all(
                width: 1,
                color: const Color.fromARGB(255, 235, 194, 80),
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 185, 185, 185),
                  size: 23,
                ),
                const Text(
                  'What are you look for...',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Container(
                  height: 33,
                  width: 74,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 194, 80),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
    );
  }
}

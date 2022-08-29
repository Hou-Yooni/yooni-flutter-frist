// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class FullImagesScreen extends StatefulWidget {
  final List<dynamic> imageList;

  const FullImagesScreen({super.key, required this.imageList});
  @override
  State<FullImagesScreen> createState() => _FullImagesScreenState();
}

class _FullImagesScreenState extends State<FullImagesScreen> {
  final PageController _pageController = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                ('${index + 1}') + ('/') + (widget.imageList.length.toString()),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              controller: _pageController,
              children: List.generate(
                widget.imageList.length,
                (index) => Image.network(
                  widget.imageList[index].toString(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(index);
                  },
                  child: Image.network(widget.imageList[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

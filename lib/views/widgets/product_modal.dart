import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/views/detail/product_detail_screen.dart';

// ignore: non_constant_identifier_names
GestureDetector ProductModal(
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index, context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProductDetailScreen(
          productList: snapshot.data!.docs[index],
        );
      }));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(minHeight: 100, maxHeight: 250),
                    child: Image.network(
                        //[0]從第0個開始取
                        snapshot.data!.docs[index]['productImages'][0]),
                  ),
                ),
                Text(snapshot.data!.docs[index]['productName']),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        snapshot.data!.docs[index]['price'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_outlined),
                        color: const Color.fromARGB(255, 247, 147, 155),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Badge(
              toAnimate: true,
              shape: BadgeShape.square,
              badgeColor: const Color.fromARGB(255, 235, 194, 80),
              borderRadius: BorderRadius.circular(15),
              badgeContent: const Text(
                'New Arrivals',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

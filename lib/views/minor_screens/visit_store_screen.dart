// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../widgets/product_modal.dart';

class VisitStoreScreen extends StatelessWidget {
  final sellerUid;

  const VisitStoreScreen({super.key, required this.sellerUid});
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('sellerUid', isEqualTo: sellerUid)
        .snapshots();
    CollectionReference seller =
        FirebaseFirestore.instance.collection('sellers');

    return FutureBuilder<DocumentSnapshot>(
      future: seller.doc(sellerUid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              title: Text(
                data['storeName'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                ),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: productsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 235, 194, 80),
                    ),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'This Store \n\n has no item yet .',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  );
                }

                return StaggeredGridView.countBuilder(
                  //設為true 僅佔用它需要的空間（當有更多項目時它仍會滾動）
                  //設為flase 會嘗試填充父元素提供的所有可用空間，即使列表項需要更少的空間
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  crossAxisCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductModal(snapshot, index, context);
                  },
                  staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 235, 194, 80),
              onPressed: () {},
              child: const Icon(FontAwesomeIcons.whatsapp),
            ),
          );
        }

        return const Material(
          child: Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 235, 194, 80),
            ),
          ),
        );
      },
    );
  }
}

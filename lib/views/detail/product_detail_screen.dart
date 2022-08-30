import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/views/minor_screens/visit_store_screen.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../widgets/full_images_screen.dart';
import '../widgets/product_modal.dart';

// ignore: use_key_in_widget_constructors
class ProductDetailScreen extends StatelessWidget {
  final dynamic productList;

  const ProductDetailScreen({super.key, required this.productList});
  @override
  Widget build(BuildContext context) {
    final List<dynamic> images = productList['productImages'];
    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('mainCategory', isEqualTo: productList['mainCategory'])
        .where('subCategory', isEqualTo: productList['subCategory'])
        .snapshots();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FullImagesScreen(imageList: images);
                      }));
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Swiper(
                        itemCount: images.length,
                        pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.grey,
                            activeColor: Color.fromARGB(255, 235, 194, 80),
                          ),
                        ),
                        itemBuilder: (context, index) {
                          return Image.network(images[index]);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  )
                ],
              ),
              Text(
                productList['productName'],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.grey.shade600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'TW',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          productList['price'].toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Color.fromARGB(255, 247, 147, 155),
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                '${productList['instoke']} pieces available in Stock',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20,
                    width: 50,
                    child: Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      'Item Description',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 235, 194, 80),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 50,
                    child: Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  productList['productDescription'],
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20,
                    width: 50,
                    child: Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      'Similar Item',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 235, 194, 80),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 50,
                    child: Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: StreamBuilder<QuerySnapshot>(
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
                          'This Category \n\n has no item yet .',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: StaggeredGridView.countBuilder(
                        //設為true 僅佔用它需要的空間（當有更多項目時它仍會滾動）
                        //設為flase 會嘗試填充父元素提供的所有可用空間，即使列表項需要更少的空間
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        crossAxisCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductModal(snapshot, index, context);
                        },
                        staggeredTileBuilder: (context) =>
                            const StaggeredTile.fit(1),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VisitStoreScreen(sellerUid: productList['sellerUid']),
                  ),
                );
              },
              icon: Icon(
                Icons.store,
                color: Colors.grey.shade600,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey.shade600,
              ),
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 194, 80),
                borderRadius: BorderRadius.circular(10),
              ),
              child: MaterialButton(
                onPressed: () {},
                child: const Text(
                  'ADD TO CART',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

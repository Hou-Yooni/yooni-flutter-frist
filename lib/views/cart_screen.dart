import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.black26,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Cart is Empty',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black26,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Material(
              borderRadius: BorderRadius.circular(30),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.6,
                onPressed: () {},
                height: 40,
                color: const Color.fromARGB(255, 235, 194, 80),
                elevation: 0,
                child: const Text(
                  'countinue shopping',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Row(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.55,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 231, 231, 231),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Text(
                    'Total: \$',
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    ' 00.00',
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ignore: avoid_unnecessary_containers
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 235, 194, 80),
            ),
            child: MaterialButton(
              onPressed: () {},
              child: const Text(
                'CHECK OUT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

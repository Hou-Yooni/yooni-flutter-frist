// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference customer =
        FirebaseFirestore.instance.collection('customers');
    return FutureBuilder(
      future: customer.doc(auth.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('something went wrong');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text('document does not exist');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: Colors.grey, //擺脫預設顏色
                  expandedHeight: 140,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      return FlexibleSpaceBar(
                        title: AnimatedOpacity(
                          opacity: constraints.biggest.height <= 120 ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: const Text('Account'),
                        ),
                        background: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 235, 194, 80),
                                Color.fromARGB(255, 255, 238, 190),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  // backgroundImage: AssetImage(
                                  //   'assets/images/app_logo/guest.jpg',
                                  // ),
                                  backgroundImage: NetworkImage(
                                    '${data['image']}',
                                  ),
                                ),
                                SizedBox(width: 25),
                                Text(
                                  '${data['fullName']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: const Center(
                                    child: Text(
                                      'Cart',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: const Color.fromARGB(255, 235, 194, 80),
                              child: TextButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: const Center(
                                    child: Text(
                                      'Order',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: const Center(
                                    child: Text(
                                      'Wishlist',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RepeatedDivider(title: 'Account Info'),
                      Padding(
                        padding: const EdgeInsets.all(
                          10.0,
                        ), //EdgeInsets 分别指定四个方向的填充所以依照邊界的10個填充 因此也不用下width
                        child: Container(
                          height: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              RepeatedListTitle(
                                title: 'Eamil address',
                                subtitle: '${data['email']}',
                                leading: Icons.email,
                              ),
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Divider(
                                  color: Color.fromARGB(31, 160, 160, 160),
                                  thickness: 1,
                                ),
                              ),
                              RepeatedListTitle(
                                title: 'Phone No',
                                subtitle: '+886 987 654 321',
                                leading: Icons.phone,
                              ),
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Divider(
                                  color: Color.fromARGB(31, 160, 160, 160),
                                  thickness: 1,
                                ),
                              ),
                              RepeatedListTitle(
                                title: 'Address',
                                subtitle: 'Makava Street',
                                leading: Icons.location_pin,
                              ),
                            ],
                          ),
                        ),
                      ),
                      RepeatedDivider(title: 'Account Settings'),
                      Padding(
                        padding: const EdgeInsets.all(
                          10.0,
                        ), //EdgeInsets 分别指定四个方向的填充所以依照邊界的10個填充 因此也不用下width
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              RepeatedListTitle(
                                title: 'Edit Profile',
                                leading: Icons.edit,
                              ),
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Divider(
                                  color: Color.fromARGB(31, 160, 160, 160),
                                  thickness: 1,
                                ),
                              ),
                              RepeatedListTitle(
                                title: 'Change Password',
                                leading: Icons.lock,
                              ),
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Divider(
                                  color: Color.fromARGB(31, 160, 160, 160),
                                  thickness: 1,
                                ),
                              ),
                              RepeatedListTitle(
                                title: 'Logout',
                                leading: Icons.logout,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 235, 194, 80),
          ),
        );
      },
    );
  }
}

class RepeatedListTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData leading;
  const RepeatedListTitle({
    required this.title,
    this.subtitle,
    required this.leading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      subtitle: Text(
        subtitle ?? '',
        style: TextStyle(
          fontSize: 13,
          color: Colors.black26,
        ),
      ),
      leading: Icon(
        leading,
        color: Color.fromARGB(255, 235, 194, 80),
      ),
    );
  }
}

class RepeatedDivider extends StatelessWidget {
  final String title;
  const RepeatedDivider({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
            title,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
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
    );
  }
}

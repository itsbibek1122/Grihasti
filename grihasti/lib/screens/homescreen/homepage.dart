import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/provider/favourite_provider.dart';
import 'package:grihasti/screens/authentication/components/authentication_appbar.dart';
import 'package:grihasti/screens/authentication/components/my_textfield.dart';
import 'package:grihasti/screens/authentication/components/square_tile.dart';
import 'package:grihasti/screens/homescreen/components/custom_drawer.dart';
import 'package:grihasti/screens/homescreen/components/favproduct.dart';
import 'package:grihasti/screens/homescreen/components/other_products.dart';
import 'package:grihasti/screens/homescreen/components/page_title.dart';
import 'package:grihasti/screens/homescreen/components/product_card.dart';
import 'package:grihasti/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'components/custom_appbar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference propertiesCollection =
      FirebaseFirestore.instance.collection('properties');
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: MyAppBar(
          title: 'Home',
        ),
        drawer: CustomDrawer(),
        body: StreamBuilder<QuerySnapshot>(
            stream: propertiesCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                  child: Column(children: [
                Container(
                  height: size.height * 0.23,
                  width: size.height,
                  color: Color(0xFF1B1A25),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome Back !',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          (FirebaseAuth.instance.currentUser!.email).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.7,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xFFFA902E),
                                  ),
                                  hintText: 'Search...',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 35.0),
                              child: Container(
                                height: 55,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(0xFFFA902E),
                                ),
                                child: Icon(Icons.filter_alt_off_sharp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTitle(
                  maintext: 'Recent Postings',
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: snapshot.data!.docs.map((doc) {
                        final imageUrl = doc['images'][0];
                        final storageRef =
                            FirebaseStorage.instance.ref(imageUrl);
                        return ProductCard(
                          title: doc['propertyTitle'],
                          location: doc['detailedLocation'],
                          price: int.parse(doc['price']),
                          imageUrl: imageUrl,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomTitle(maintext: 'Other Properties'),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      OtherCard(
                        title: "Kathford College",
                        description: "Best college",
                        imageUrl: 'assets/images/house_three.jpg',
                        price: '14000',
                        product: FavProduct(
                          title: 'Kathford College',
                          imageUrl: 'assets/images/house_three.jpg',
                          isFavorite: false,
                        ),
                      ),
                      OtherCard(
                        title: "Hostel",
                        description: "Best Hostel",
                        imageUrl: 'assets/images/house_two.jpg',
                        price: '35000',
                        product: FavProduct(
                          title: 'Best Hostel',
                          imageUrl: 'assets/images/house_two.jpg',
                          isFavorite: false,
                        ),
                      )
                    ],
                  ),
                )
              ]));
            }));
  }
}

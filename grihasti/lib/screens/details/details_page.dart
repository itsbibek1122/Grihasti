import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grihasti/screens/authentication/components/my_button.dart';
import 'package:grihasti/screens/details/components/carousel_index.dart';
import 'package:grihasti/screens/details/components/custom_indicator.dart';

import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';
import 'package:grihasti/screens/homescreen/components/custom_drawer.dart';
import 'package:grihasti/screens/homescreen/components/other_products.dart';
import 'package:grihasti/utils/showSnackBar.dart';
import 'package:grihasti/utils/style/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

class PropertyDetailsPage extends StatefulWidget {
  final String documentId;
  PropertyDetailsPage(this.documentId);

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final CollectionReference propertiesCollection =
      FirebaseFirestore.instance.collection('properties');

  @override
  Widget build(BuildContext context) {
    final documentId = ModalRoute.of(context)!.settings.arguments as String;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final imageIndexProvider = Provider.of<ImageIndexProvider>(context);

    // final List<String> imgList = [
    //   'assets/images/house_one.jpg',
    //   'assets/images/house_two.jpg',
    //   'assets/images/house_three.jpg',
    // ];

    return Scaffold(
      appBar: MyAppBar(title: 'Property Details'),
      drawer: CustomDrawer(),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('properties')
            .doc(documentId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Text(
                'Document not found'); // Handle if document doesn't exist
          }
          final propertyData = snapshot.data!.data() as Map<String, dynamic>?;

          if (propertyData == null) {
            return Text('Data not available'); // Handle if data is null
          }

          final propertyTitle = propertyData['propertyTitle'] ?? 'Default';
          final detailedLocation =
              propertyData['detailedLocation'] ?? 'Default';
          final price = propertyData['price'] ?? 'Default';
          final city = propertyData['city'] ?? 'Default';
          final propertyDescription =
              propertyData['propertyDescription'] ?? 'Default';
          final purpose = propertyData['purpose'] ?? 'Default';
          final ownerName = propertyData['ownerName'] ?? 'Default';
          final ownerNumber = propertyData['ownerNumber'] ?? 'Default';
          final map = propertyData['location'] ?? 'Default';
          List<dynamic> images = snapshot.data!['images'];

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Document ID: $documentId'),
                  CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        imageIndexProvider.updateIndex(index);
                      },
                    ),
                    items: images.map((item) {
                      return Container(
                        child: Center(
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: width * 0.75,
                            height: height * 0.5,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: images.map((url) {
                      int index = images.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: imageIndexProvider.currentIndex == index
                              ? AppColors.orangeColor
                              : AppColors.blackColor,
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$propertyTitle',
                      style: TextStyle(
                          fontSize: width * 0.06, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Purpose : $purpose',
                      style: TextStyle(
                          fontSize: width * 0.04, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Npr. $price',
                          style: TextStyle(
                              fontSize: width * 0.07,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75.0),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: IconButton(
                                onPressed: () => MapsLauncher.launchCoordinates(
                                    map.latitude,
                                    map.longitude,
                                    '$propertyTitle'),
                                icon: const Icon(
                                  Icons.directions,
                                )),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: IconButton(
                              style: ButtonStyle(),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$detailedLocation, $city',
                      style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomIndicator(
                            iconData: Icons.bedroom_parent_rounded, value: 2),
                        CustomIndicator(
                            iconData: Icons.bathtub_rounded, value: 3),
                        CustomIndicator(
                            iconData: Icons.dining_rounded, value: 2),
                        CustomIndicator(
                            iconData: Icons.car_repair_rounded, value: 1),
                        CustomIndicator(
                            iconData: Icons.motorcycle_rounded, value: 5)
                      ],
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    indent: 25,
                    endIndent: 10,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$propertyDescription',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Create a Uri object with the phone number.
                              Uri phoneno = Uri.parse('tel:$ownerNumber');

                              // Try to launch the dialer with the phone number.
                              if (await launchUrl(phoneno)) {
                                CircularProgressIndicator();
                              } else {
                                mySnackBar(context, 'Dailer Error');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1B1A25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Icon(Icons.call),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '$ownerName',
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1B1A25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Icon(Icons.chat_rounded),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '$ownerName',
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 15.0, 0, 0),
                    child: AuthenticationButton(text: 'Book', onPressed: () {}),
                  ),
                ],
              ),
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy < 0) {
                    // You can add conditions to restrict the drag behavior
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            // Content of the bottom sheet here
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Other Properties you may like',
                                    style: TextStyle(
                                        fontSize: width * 0.05,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const Divider(
                                  height: 25,
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 0,
                                  color: Colors.grey,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: propertiesCollection.snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }

                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: snapshot.data!.docs
                                            .where((doc) =>
                                                doc['purpose'] == purpose)
                                            .map((doc) {
                                          final documentId =
                                              doc.id; // Get the document ID
                                          final imageUrl = doc['images'][0];
                                          final storageRef = FirebaseStorage
                                              .instance
                                              .ref(imageUrl);
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/details',
                                                  arguments: documentId);
                                            },
                                            child: OtherCard(
                                              title: doc['propertyTitle'],
                                              description:
                                                  doc['detailedLocation'],
                                              imageUrl: imageUrl,
                                              price: int.parse(doc['price']),
                                              purpose: doc['purpose'],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

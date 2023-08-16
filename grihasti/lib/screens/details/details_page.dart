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
import 'package:grihasti/utils/style/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

class PropertyDetailsPage extends StatelessWidget {
  final List<String> imgList = [
    'assets/images/house_one.jpg',
    'assets/images/house_two.jpg',
    'assets/images/house_three.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final CollectionReference propertiesCollection =
        FirebaseFirestore.instance.collection('properties');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final imageIndexProvider = Provider.of<ImageIndexProvider>(context);

    return Scaffold(
      appBar: MyAppBar(title: 'Property Details'),
      drawer: CustomDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: propertiesCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        imageIndexProvider.updateIndex(index);
                      },
                    ),
                    items: imgList.map((item) {
                      return Container(
                        child: Center(
                          child: Image.asset(
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
                    children: imgList.map((url) {
                      int index = imgList.indexOf(url);
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
                      'Rent',
                      style: TextStyle(
                          fontSize: width * 0.05, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Npr. 55,000',
                          style: TextStyle(
                              fontSize: width * 0.08,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75.0),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: IconButton(
                                onPressed: () => MapsLauncher.launchCoordinates(
                                    37.4220041,
                                    -122.0862462,
                                    'Google Headquarters are here'),
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
                      'Near Main Road, Lalitpur',
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
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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
                              Uri phoneno = Uri.parse('tel:+97798345348734');
                              if (await launchUrl(phoneno)) {
                                //dialer opened
                              } else {
                                //dailer is not opened
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1B1A25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.call),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Owner Name',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ],
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
                            child: Row(
                              children: [
                                Icon(Icons.chat_rounded),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Owner Name',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
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
                                Column(
                                  children: snapshot.data!.docs.map((doc) {
                                    final imageUrl = doc['images'][0];
                                    final storageRef =
                                        FirebaseStorage.instance.ref(imageUrl);

                                    return OtherCard(
                                      title: doc['propertyTitle'],
                                      description: doc['detailedLocation'],
                                      imageUrl: imageUrl,
                                      price: int.parse(doc['price']),
                                      purpose: doc['purpose'],
                                    );
                                  }).toList(),
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

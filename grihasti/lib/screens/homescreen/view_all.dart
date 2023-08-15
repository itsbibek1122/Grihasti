import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/provider/purpose_filter.dart';
import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';
import 'package:grihasti/screens/homescreen/components/other_products.dart';
import 'package:grihasti/screens/homescreen/components/product_card.dart';
import 'package:grihasti/utils/style/colors.dart';
import 'package:provider/provider.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  final CollectionReference propertiesCollection =
      FirebaseFirestore.instance.collection('properties');
  final List<String> purposeOptions = ['Kathmandu', 'Bhaktapur', 'Lalitpur'];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final purposeProvider = Provider.of<PurposeFilterProvider>(context);
    return Scaffold(
      appBar: MyAppBar(title: 'All Properties'),
      body: Column(children: [
        Row(
          children: purposeOptions.map((purpose) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(spacing: 8.0, children: <Widget>[
                FilterChip(
                  shape: StadiumBorder(side: BorderSide()),
                  elevation: 1,
                  backgroundColor: AppColors.blackColor,
                  selectedColor: AppColors.orangeColor,
                  label: Text(
                    purpose,
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: purposeProvider.selectedPurpose == purpose,
                  onSelected: (selected) {
                    purposeProvider.updateSelectedPurpose(
                        selected ? purpose : 'Kathmandu');
                  },
                ),
              ]),
            );
          }).toList(),
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: propertiesCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: snapshot.data!.docs
                      .where((doc) =>
                          doc['city'] == purposeProvider.selectedPurpose)
                      .map((doc) {
                    final imageUrl = doc['images'][0];
                    final storageRef = FirebaseStorage.instance.ref(imageUrl);
                    return OtherCard(
                      title: doc['propertyTitle'],
                      description: doc['detailedLocation'],
                      price: int.parse(doc['price']),
                      imageUrl: imageUrl,
                      purpose: doc['purpose'],
                    );
                  }).toList(),
                ),
              );
            }),
      ]),
    );
  }
}

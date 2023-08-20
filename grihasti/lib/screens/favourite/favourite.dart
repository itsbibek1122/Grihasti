import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grihasti/provider/user_provider.dart';
import 'package:grihasti/screens/homescreen/components/other_products.dart';
import 'package:provider/provider.dart';

class SavedPropertiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;
    // Retrieve the user's ID (you need to implement this)
    final savedPropertiesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('savedProperties');

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Properties'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: savedPropertiesCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('You have no saved properties.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((property) {
              final propertyId = property['propertyId'];
              final propertyTitle = property['propertyTitle'];
              final detailedLocation = property['detailedLocation'];
              final imageUrl = property['imageUrl'];
              final price = property['price'];
              final purpose = property['purpose'];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/details',
                      arguments: propertyId);
                },
                child: OtherCard(
                  title: propertyTitle,
                  description: 'Location: $detailedLocation',
                  imageUrl: imageUrl,
                  price: int.parse(price),
                  purpose: purpose,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

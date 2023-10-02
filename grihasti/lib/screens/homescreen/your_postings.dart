import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';
import 'package:grihasti/screens/homescreen/components/other_products.dart';

class YourPostings extends StatefulWidget {
  final String userId;

  YourPostings(this.userId);

  @override
  _YourPostingsState createState() => _YourPostingsState();
}

class _YourPostingsState extends State<YourPostings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Your Postings'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('properties')
            .where('userId', isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('You have not posted any properties.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var posting = snapshot.data!.docs[index];
              final documentId = posting.id;
              final imageUrl = posting['images'][0];

              // return ListTile(
              //   title: Text(posting['propertyTitle']),
              //   trailing: IconButton(
              //     icon: Icon(Icons.delete),
              //     onPressed: () async {
              //       // Delete the booking from Firestore
              //       await FirebaseFirestore.instance
              //           .collection('postings')
              //           .doc(posting.id)
              //           .delete();
              //     },
              //   ),
              // );
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/details',
                      arguments: documentId);
                },
                child: OtherCard(
                  title: posting['propertyTitle'],
                  description: posting['detailedLocation'],
                  imageUrl: imageUrl,
                  price: int.parse(posting['price']),
                  purpose: posting['purpose'],
                  iconData: Icons.delete,
                  onPressed: () async {
                    print('delete clicked');
                    await FirebaseFirestore.instance
                        .collection('properties')
                        .doc(posting.id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

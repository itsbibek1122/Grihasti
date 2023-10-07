import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';

class BookedPropertiesScreen extends StatefulWidget {
  final String userId;

  BookedPropertiesScreen(this.userId);

  @override
  _BookedPropertiesScreenState createState() => _BookedPropertiesScreenState();
}

class _BookedPropertiesScreenState extends State<BookedPropertiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Properties Booked'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('bookedId', isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('You have no booked properties.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var booking = snapshot.data!.docs[index];
              return ListTile(
                title: Text(booking['propertyTitle']),
                subtitle: Text('Booked on: ${booking['bookedDate']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    // Delete the booking from Firestore
                    await FirebaseFirestore.instance
                        .collection('bookings')
                        .doc(booking.id)
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

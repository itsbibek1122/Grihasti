import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';

Future<void> bookProperty(
    BuildContext context,
    String widgetDocumentId,
    String postedBy,
    String userId,
    String propertyTitle,
    String detailedLocation,
    String price) async {
  // Get the selected date from the user
  DateTime? selectedDate;
  selectedDate = await DatePickerBdaya.showDatePicker(context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime.now().add(Duration(days: 60)));

  if (selectedDate != null) {
    // Check if the property is already booked for the selected date
    final query = FirebaseFirestore.instance
        .collection('bookings')
        .where('propertyId', isEqualTo: widgetDocumentId)
        .where('bookedDate', isEqualTo: selectedDate.toIso8601String());

    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      // The property is already booked for the selected date.
      mySnackBar(context, 'This property is already booked for this date');
    } else if (postedBy == userId) {
      // The user who posted the property is trying to book it.
      mySnackBar(context, 'You cannot book your own property');
    } else {
      // The property is not booked for the selected date, and it's not the user's own property.
      // Convert the selected date to ISO8601 format and store it in 'bookedDate'
      String iso8601Date = selectedDate.toIso8601String();

      // Create the booking data
      final bookingData = {
        'propertyTitle': propertyTitle,
        'detailedLocation': detailedLocation,
        'price': price,
        'bookedDate': iso8601Date,
        'bookedId': userId,
        'propertyId': widgetDocumentId,
        'postedBy': postedBy,
      };

      try {
        // Add the booking data to Firestore
        await FirebaseFirestore.instance
            .collection('bookings')
            .add(bookingData);

        // Display a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking confirmed for $selectedDate'),
          ),
        );
      } catch (e) {
        // Handle any errors that occur during booking
        print("Error adding booking data: $e");
      }
    }
  }
}

void mySnackBar(BuildContext context, String message) {
  // Implement your SnackBar logic here
  // Example:
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

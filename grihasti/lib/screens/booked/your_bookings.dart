import 'package:flutter/material.dart';

class BookedPropertyScreen extends StatelessWidget {
  final String propertyTitle;
  final String detailedLocation;
  final double price;
  final DateTime? selectedDate;

  // Constructor to receive the property data
  BookedPropertyScreen({
    required this.propertyTitle,
    required this.detailedLocation,
    required this.price,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booked Property Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Title: $propertyTitle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Detailed Location: $detailedLocation'),
            Text('Price: \$${price.toStringAsFixed(2)}'),
            if (selectedDate != null)
              Text('Booked Date: ${selectedDate.toString()}'),
            // Add more information here if needed
          ],
        ),
      ),
    );
  }
}

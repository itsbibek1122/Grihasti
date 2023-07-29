import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  // Pass the necessary data as constructor parameters

  final String propertyTitle;
  final String propertyDescription;
  final String propertyImage;

  DetailsPage({
    required this.propertyTitle,
    required this.propertyDescription,
    required this.propertyImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Property image
            Image.network(propertyImage),

            // Property title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                propertyTitle,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Property description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                propertyDescription,
                style: TextStyle(fontSize: 16),
              ),
            ),

            // Add more property details here (e.g., price, location, etc.)
          ],
        ),
      ),
    );
  }
}

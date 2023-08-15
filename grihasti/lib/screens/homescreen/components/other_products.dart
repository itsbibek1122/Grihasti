import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:grihasti/provider/favourite_provider.dart';
import 'package:grihasti/screens/details/details_page.dart';
import 'package:grihasti/screens/homescreen/components/favproduct.dart';
import 'package:grihasti/utils/style/colors.dart';
import 'package:provider/provider.dart';

class OtherCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final int price;
  final String purpose;

  OtherCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.purpose,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "$price /month",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FittedBox(
              child: Container(
                color: AppColors.orangeColor,
                child: Text(
                  purpose,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white), // Adjust the font size as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

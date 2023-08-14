import 'package:flutter/material.dart';
import 'package:grihasti/screens/details/details_page.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String location;
  final int price;

  ProductCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          width: size.width * 0.6,
          height: 215,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  imageUrl == null
                      ? Image.network(
                          'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ) // Show loading indicator if imageUrl is null
                      : Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amber,
                    ),
                    child: Icon(
                      Icons.bookmark,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.pin_drop_rounded,
                            size: 15.0,
                            color: Colors.black87,
                          ),
                          Text(
                            location,
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "$price + /month",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

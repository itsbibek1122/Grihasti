import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String maintext;

  const CustomTitle({super.key, required this.maintext});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                maintext,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  'View All',
                  style: TextStyle(
                      color: Color(0xFFFA902E), fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';

void showOtherPropertiesBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Other Properties you may like',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(
                height: 25,
                thickness: 1,
                indent: 10,
                endIndent: 0,
                color: Colors.grey,
              ),
              // Rest of your bottom sheet content
            ],
          ),
        ),
      );
    },
  );
}

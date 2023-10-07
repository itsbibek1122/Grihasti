import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: MyAppBar(title: 'Coming Soon'),
      body: Column(
        children: [
          Image.asset('assets/images/working.gif'),
          Text(
            'Working on this feature',
            style: TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }
}

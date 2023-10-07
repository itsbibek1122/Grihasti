import 'package:flutter/material.dart';
import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';
import 'package:grihasti/screens/homescreen/components/custom_drawer.dart';

class GScreen extends StatelessWidget {
  const GScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Profile',
      ),
      drawer: CustomDrawer(),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

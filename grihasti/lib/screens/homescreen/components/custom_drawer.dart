import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/services/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut().then((value) =>
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false));
    }

    return Drawer(
      backgroundColor: Color(0xFF1B1A25),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              child: Center(
            child: Text(
              'Grihasti',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
          )),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.near_me, color: Colors.white),
            title: Text(
              'Near me',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle the onTap event for this item
            },
          ),
          ListTile(
            leading: Icon(Icons.house_sharp, color: Colors.white),
            title: const Text(
              'Post Property',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/addProperty');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_checkout, color: Colors.white),
            title: const Text(
              'WishList',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/wishlist');
            },
          ),
          ListTile(
            leading:
                Icon(Icons.supervised_user_circle_rounded, color: Colors.white),
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading:
                Icon(Icons.supervised_user_circle_rounded, color: Colors.white),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/chat/chat_screen.dart';
import 'package:grihasti/coming_soon.dart';
import 'package:grihasti/profile.dart';
import 'package:grihasti/screens/add_property/add_property.dart';
import 'package:grihasti/screens/add_property/map_screen.dart';
import 'package:grihasti/screens/add_property/model/maps.dart';
import 'package:grihasti/screens/authentication/forgot_password.dart';
import 'package:grihasti/screens/authentication/login_screen.dart';
import 'package:grihasti/screens/authentication/signup_screen.dart';
import 'package:grihasti/screens/booked/booked_properties.dart';
import 'package:grihasti/screens/details/details_page.dart';
import 'package:grihasti/screens/favourite/favourite.dart';
import 'package:grihasti/screens/details/components/emi_screen.dart';
import 'package:grihasti/screens/homescreen/homepage.dart';
import 'package:grihasti/screens/homescreen/profilepage.dart';
import 'package:grihasti/screens/homescreen/view_all.dart';
import 'package:grihasti/screens/homescreen/your_postings.dart';
import 'package:grihasti/screens/maps_view/maps_view.dart';
import 'package:grihasti/splashscreen.dart';
import 'package:latlong2/latlong.dart';

var routes = <String, WidgetBuilder>{
  '/': (context) => WelcomeScreen(),
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignUpScreen(),
  '/forgetpassword': (context) => ForgotPasswordScreen(),
  '/home': (context) => HomePage(),
  '/wishlist': (context) => SavedPropertiesScreen(),
  '/profile': (context) => ProfilePage(),
  '/addProperty': (context) => AddProperty(),
  '/mapScreen': (context) => MapScreen(),
  '/emiScreen': (context) => EmiScreen(),
  '/viewAll': (context) => ViewAll(),
  '/mapsView': (context) => MapsView(),
  '/chatScreen': (context) => ChatScreen(),
  '/error': (context) => ComingSoon(),
  '/gScreen': (context) => GScreen(),
  '/booked': (context) {
    final userId = FirebaseAuth.instance.currentUser!
        .uid; // Replace with your logic to get the user ID
    return BookedPropertiesScreen(userId);
  },
  '/yourpostings': (context) {
    final userId = FirebaseAuth.instance.currentUser!
        .uid; // Replace with your logic to get the user ID
    return YourPostings(userId);
  },
  '/details': (context) =>
      PropertyDetailsPage(ModalRoute.of(context)!.settings.arguments as String),
};

import 'package:flutter/material.dart';
import 'package:grihasti/screens/add_property/add_property.dart';
import 'package:grihasti/screens/add_property/map_screen.dart';
import 'package:grihasti/screens/add_property/model/maps.dart';
import 'package:grihasti/screens/authentication/forgot_password.dart';
import 'package:grihasti/screens/authentication/login_screen.dart';
import 'package:grihasti/screens/authentication/signup_screen.dart';
import 'package:grihasti/screens/details/details_page.dart';
import 'package:grihasti/screens/favourite/favourite.dart';
import 'package:grihasti/screens/homescreen/homepage.dart';
import 'package:grihasti/screens/homescreen/profilepage.dart';
import 'package:grihasti/screens/homescreen/view_all.dart';
import 'package:grihasti/screens/maps_view/maps_view.dart';
import 'package:latlong2/latlong.dart';

var routes = <String, WidgetBuilder>{
  '/': (context) => LoginScreen(),
  '/signup': (context) => SignUpScreen(),
  '/forgetpassword': (context) => ForgotPasswordScreen(),
  '/home': (context) => HomePage(),
  '/wishlist': (context) => SavedPropertiesScreen(),
  '/profile': (context) => ProfilePage(),
  '/addProperty': (context) => AddProperty(),
  '/mapScreen': (context) => MapScreen(),
  '/viewAll': (context) => ViewAll(),
  '/mapsView': (context) => MapsView(),
  '/details': (context) => PropertyDetailsPage(
        ModalRoute.of(context)!.settings.arguments as String,
      ),
};

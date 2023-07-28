import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/firebase_options.dart';
import 'package:grihasti/provider/auth_provider.dart';
import 'package:grihasti/provider/chip_provider.dart';
import 'package:grihasti/provider/favourite_provider.dart';
import 'package:grihasti/provider/location_provider.dart';

import 'package:grihasti/provider/user_provider.dart';
import 'package:grihasti/routes/routes.dart';
import 'package:grihasti/screens/authentication/login_screen.dart';
import 'package:grihasti/screens/homescreen/homepage.dart';
import 'package:grihasti/splashscreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => ChipOptions()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
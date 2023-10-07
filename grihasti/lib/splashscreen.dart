import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/screens/authentication/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            FlutterSplashScreen(
              duration: const Duration(milliseconds: 2000),
              defaultNextScreen: LoginScreen(),
              backgroundColor: Colors.white,
              splashScreenBody: Center(
                child: Image.asset(
                  "assets/images/House-animated.gif",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

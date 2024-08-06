import 'dart:async';

import 'package:beautilly/screens/onboarding_screen.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // After the given interval is completed the splash screen redirects to the onscreen page
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bPrimaryColor,
      body: Center(
        child: Image.asset(
          "assets/images/splashLogo .png",
          fit: BoxFit.cover,
          width: 157,
          height: 65,
        ),
      ),
    );
  }
}

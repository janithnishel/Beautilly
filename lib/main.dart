import 'package:beautilly/screens/customer_profile/choose_preference.dart';
import 'package:beautilly/screens/customer_profile/findservice_page.dart';
import 'package:beautilly/screens/customer_profile/nearby_beautician_salon.dart';
import 'package:beautilly/screens/join_page.dart';
import 'package:beautilly/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // Import Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Beautilly",
      theme: ThemeData(fontFamily: "Poppins"),
      home: JoinPage(),
    );
  }
}

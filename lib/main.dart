import 'package:beautilly/screens/Admin/add_preference.dart';
import 'package:beautilly/screens/Admin/saloon_visual_home.dart';
import 'package:beautilly/screens/Admin/shop_details.dart';
import 'package:beautilly/screens/Admin/target_audience.dart';
import 'package:beautilly/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
      home: SaloonVisualHome(),
    );
  }
}

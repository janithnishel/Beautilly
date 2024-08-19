import 'package:beautilly/screens/beautician_pages/filter_page.dart';
import 'package:beautilly/screens/beautician_pages/serach_page.dart';
import 'package:beautilly/screens/beautician_pages/service_prediction1_page.dart';
import 'package:beautilly/screens/beautician_pages/staff_member_profile.dart';
import 'package:beautilly/screens/customer_profile/nearby_beautician_salon.dart';
import 'package:beautilly/screens/nearby_list.dart';
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
      home:StaffMemberProfile(),
    );
  }
}

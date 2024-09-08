import 'package:beautilly/hair_treatment.dart/hair_type_prediction.dart';
import 'package:beautilly/hair_treatment.dart/upload_image.dart';
import 'package:beautilly/screens/Admin/target_audience.dart';
import 'package:beautilly/screens/beautician_pages/schedule_appointment.dart';
import 'package:beautilly/screens/beautician_pages/staff_member_profile.dart';
import 'package:beautilly/screens/beautician_pages/staff_member_profile.dart';
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
      home:UploadIamge(),
    );
  }
}

import 'package:beautilly/screens/face_pages/face_shop_details.dart';
import 'package:beautilly/screens/face_pages/face_treatment.dart';
import 'package:beautilly/screens/face_pages/face_treatment/image_uplad_page.dart';
import 'package:beautilly/screens/face_pages/face_treatment/makeup_image.dart';
import 'package:beautilly/screens/face_pages/iamge_uploader.dart';
import 'package:beautilly/screens/face_pages/makeup/image_uplad_page.dart';
import 'package:beautilly/screens/face_pages/makeup/makeup_image.dart';
import 'package:beautilly/screens/face_pages/makeup/makeup_selection.dart';
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
      home:FaceTreatmentImage(),
    );
  }
}

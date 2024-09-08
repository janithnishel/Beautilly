import 'package:beautilly/models/services_model.dart';
import 'package:beautilly/screens/Admin/saloon_visual_home.dart';
import 'package:beautilly/screens/face_pages/face_treatment/makeup_image.dart';
import 'package:beautilly/screens/face_pages/makeup/makeup_image.dart';
import 'package:beautilly/screens/hair_treatment/upload_image.dart';
import 'package:flutter/material.dart';

class ServiceData {
  final List<ServicesModel> serviceDataList = [
    ServicesModel(
      imageUrl: "assets/images/haircut.png",
      title: "Haircut",
      destinationPage: UploadIamge(), // Corrected to 'destinationPage'
    ),
    ServicesModel(
      imageUrl: "assets/images/nails.png",
      title: "Nails",
      destinationPage: MakeupImage(), // Corrected to 'destinationPage'
    ),
    ServicesModel(
      imageUrl: "assets/images/facial.png",
      title: "Facial",
      destinationPage: FaceTreatmentImage(), // Corrected to 'destinationPage'
    ),
    ServicesModel(
      imageUrl: "assets/images/coloring.png",
      title: "Coloring",
      destinationPage: SaloonVisualHome(), // Corrected to 'destinationPage'
    ),
    ServicesModel(
      imageUrl: "assets/images/spa.png",
      title: "Spa",
      destinationPage: MakeupImage(), // Corrected to 'destinationPage'
    ),
    ServicesModel(
      imageUrl: "assets/images/waxing.png",
      title: "Waxing",
      destinationPage: MakeupImage(), // Corrected to 'destinationPage'
    ),
    ServicesModel(
      imageUrl: "assets/images/makeup.png",
      title: "Makeup",
      destinationPage: MakeupImage(), // Corrected to 'destinationPage'
    ),
    ServicesModel(
      imageUrl: "assets/images/massage.png",
      title: "Massage",
      destinationPage: MakeupImage(), // Corrected to 'destinationPage'
    ),
  ];
}

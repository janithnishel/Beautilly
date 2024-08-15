import 'package:beautilly/models/beauty_card_model.dart';

class BeautyCardData {
  //create a list of data treatment type
  final List<BeautyCardModel> treatmentTypeDataList = [
    BeautyCardModel(
      descroiption: "Face Treatments",
      imageUrl: "assets/images/facial.png",
    ),
    BeautyCardModel(
        descroiption: "Hair Treatments",
        imageUrl: "assets/images/makeupBottle.png"),
  ];
  //createlist of data facial  a type
  final List<BeautyCardModel> treatmentFaceDataList = [
    BeautyCardModel(
      title: "Facial",
      descroiption: "Best Facials For Your Face",
      imageUrl: "assets/images/facial.png",
    ),
    
    BeautyCardModel(
      title: "Makeup",
      descroiption: "Try On Makeup",
      imageUrl: "assets/images/makeupBottle.png",
    ),
  ];
}

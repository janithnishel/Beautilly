import 'package:beautilly/models/beauticians%20_model.dart';

class BeauticiansData {
  final List<BeauticianModel> beauticiansDataList = [
    BeauticianModel(
        imageUrl: "assets/images/Beautician1.png",
        name: "Salon de Elegance",
        address: "360 Stillwater Rd. Palm City..",
        rateScore: 4.8,
        ratedCount: "3.1k",
        service: [
          "Haircut .",
          "Nails .",
          "Facial",
        ]),
    BeauticianModel(
        imageUrl: "assets/images/Beautician2.png",
        name: "Plush Beauty Lounge",
        address: "2607  Haymond Rocks ..",
        rateScore: 4.7,
        ratedCount: "2.7k",
        service: [
          "Haircut .",
          "facial .",
          "2+",
        ])
  ];
}

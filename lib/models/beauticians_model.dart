class BeauticianModel {
  final int beauticianId;
  final String name;
  final int age;
  final String gender;
  final String position;
  final double ratingScore;
  final String characteristics;
  final String imageUrl;
  final String salonName; // Field for Salon Name
  final int salonId; // Added field for Salon ID
  final double average_score;

  BeauticianModel({
    required this.beauticianId,
    required this.name,
    required this.age,
    required this.gender,
    required this.position,
    required this.ratingScore,
    required this.characteristics,
    required this.imageUrl,
    required this.salonName, // Constructor parameter for Salon Name
    required this.salonId, // Constructor parameter for Salon ID
    required this.average_score,
  });

  factory BeauticianModel.fromJson(Map<String, dynamic> json) {
    return BeauticianModel(
      beauticianId: json['Beautician_ID'],
      name: json['Name'],
      age: json['Age'],
      gender: json['Gender'],
      position: json['Position'],
      ratingScore: (json['Rating_Score'] as num).toDouble(),
      characteristics: json['Characteristics'],
      imageUrl: json['Image'],
      salonName: json['Salon_Name'], // Field mapping for Salon Name
      salonId: json['Salon_ID'], // Field mapping for Salon ID
      average_score: (json['average_score'] as num).toDouble(),
    );
  }
}

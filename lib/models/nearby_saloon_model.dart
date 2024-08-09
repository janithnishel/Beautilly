class NearbySaloonModel {
  final String imageUrl;
  final String salonName;
  final double rateScore;
  final String distance;
  final String address;
  final String ratedCount;

  NearbySaloonModel(
      {required this.imageUrl,
      required this.salonName,
      required this.rateScore,
      required this.distance,
      required this.address,
      required this.ratedCount});
}

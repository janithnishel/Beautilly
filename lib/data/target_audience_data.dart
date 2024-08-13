import 'package:beautilly/models/target_audience_model.dart';

class TargetAudienceData {
  final List<TargetAudienceModel> TargetAudienceAgeList = [
    TargetAudienceModel(title: "18-24"),
    TargetAudienceModel(title: "25-34"),
    TargetAudienceModel(title: "35-44"),
    TargetAudienceModel(title: "45-54"),
  ];
  final List<TargetAudienceModel> TargetAudienceGenderList = [
    TargetAudienceModel(title: "Male"),
    TargetAudienceModel(title: "Female")
  ];
  final List<TargetAudienceModel> TargetAudienceIncomeList = [
    TargetAudienceModel(title: "Low"),
    TargetAudienceModel(title: "Middle"),
    TargetAudienceModel(title: "High"),
  ];
}

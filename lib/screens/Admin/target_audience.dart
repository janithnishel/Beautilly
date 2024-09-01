import 'package:beautilly/data/target_audience_data.dart';
import 'package:beautilly/screens/Admin/shop_details.dart';
import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/utils/global_state.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';


class TargetAudience extends StatefulWidget {
  const TargetAudience({super.key});

  @override
  State<TargetAudience> createState() => _TargetAudienceState();
}

class _TargetAudienceState extends State<TargetAudience> {
  final _audienceData = TargetAudienceData();

  int _indexAge = 99;
  int _indexGender = 99;
  int _indexIncome = 99;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/images/targetAudience.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          "assets/images/backArrow.png",
                          fit: BoxFit.cover,
                          color: bPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "WHAT IS YOUR TARGET \nAUDIENCE?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff111111),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomBox(
                    isHaSBorder: true,
                    widget: Padding(
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 24, bottom: 16),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _audienceData.TargetAudienceAgeList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _indexAge = index;
                                      // Update the global variable
                                      GlobalState.selectedAgeGroup = _audienceData
                                          .TargetAudienceAgeList[index].title;
                                    });
                                  },
                                  child: CustomButton(
                                    title: _audienceData
                                        .TargetAudienceAgeList[index].title,
                                    isHasMultipleWidget: false,
                                    color: _indexAge == index
                                        ? bPrimaryLightColor
                                        : bWhite,
                                    textColor: bBlackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    borderColor: _indexAge == index
                                        ? bPrimaryColor
                                        : bGrey.withOpacity(0.3),
                                    width: 100,
                                    height: 35,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomBox(
                    isHaSBorder: true,
                    widget: Padding(
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 24, bottom: 16),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                _audienceData.TargetAudienceGenderList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _indexGender = index;
                                      // Update the global variable
                                      GlobalState.selectedGender = _audienceData
                                          .TargetAudienceGenderList[index].title;
                                    });
                                  },
                                  child: CustomButton(
                                    title: _audienceData
                                        .TargetAudienceGenderList[index].title,
                                    isHasMultipleWidget: false,
                                    color: _indexGender == index
                                        ? bPrimaryLightColor
                                        : bWhite,
                                    textColor: bBlackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    borderColor: _indexGender == index
                                        ? bPrimaryColor
                                        : bGrey.withOpacity(0.3),
                                    width: 100,
                                    height: 35,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomBox(
                    isHaSBorder: true,
                    widget: Padding(
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 24, bottom: 16),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                _audienceData.TargetAudienceIncomeList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _indexIncome = index;
                                      // Update the global variable
                                      GlobalState.selectedIncome = _audienceData
                                          .TargetAudienceIncomeList[index].title;
                                    });
                                  },
                                  child: CustomButton(
                                    title: _audienceData
                                        .TargetAudienceIncomeList[index].title,
                                    isHasMultipleWidget: false,
                                    color: _indexIncome == index
                                        ? bPrimaryLightColor
                                        : bWhite,
                                    textColor: bBlackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    borderColor: _indexIncome == index
                                        ? bPrimaryColor
                                        : bGrey.withOpacity(0.3),
                                    width: 100,
                                    height: 35,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: _isLoading ? null : _onNextPressed, // Prevent multiple taps
                    child: _isLoading // Show progress indicator if loading
                        ? CircularProgressIndicator()
                        : CustomButton(
                            title: "NEXT",
                            isHasMultipleWidget: false,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onNextPressed() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch visuals data based on selected target audience
      final visuals = await ApiService.getVisualsByCustomerAttributes(
        GlobalState.selectedGender,
        GlobalState.selectedAgeGroup,
        GlobalState.selectedIncome,
      );

      // Navigate to ShopDetails with visuals data
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShopDetails(
            visuals: visuals,
          ),
        ),
      );
    } catch (e) {
      print('Error: $e');
      // Handle errors here (e.g., show a snackbar or alert)
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';

class HairTypePrediction extends StatefulWidget {
  final String selectedPriceRange;
  final List<Map<String, dynamic>> recommendations;

  const HairTypePrediction({
    Key? key,
    required this.selectedPriceRange,
    required this.recommendations,
  }) : super(key: key);

  @override
  State<HairTypePrediction> createState() => _HairTypePredictionState();
}

class _HairTypePredictionState extends State<HairTypePrediction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/hairBackground.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Column(
                children: [
                  CustomBox(
                    widget: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_sharp,
                              color: bPrimaryColor,
                              size: 16,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.87,
                            child: const Center(
                              child: Text(
                                "Hair Type Prediction",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: bBlackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isHaSBorder: false,
                    borderRadius: 0,
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: bWhite.withOpacity(0.9),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          color: bWhite.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 50),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.57,
                              child: ListView.builder(
                                itemCount: widget.recommendations.length,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final recommendation = widget.recommendations[index];
                                  return _recommendationCard(recommendation);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              title: "OK",
                              isHasMultipleWidget: false,
                              fontWeight: FontWeight.w500,
                              color: bPrimaryColor.withOpacity(0.8),
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Display recommendation details
  Widget _recommendationCard(Map<String, dynamic> recommendation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recommendation['Treatment Name'],
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: bBlackColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Product: ${recommendation['Product Name']}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: bBlackColor,
          ),
        ),
        Text(
          "Ingredients: ${recommendation['Key Ingredients']}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: bBlackColor,
          ),
        ),
        Text(
          "Tips: ${recommendation['Tips']}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: bBlackColor,
          ),
        ),
        const Divider(),
      ],
    );
  }
}

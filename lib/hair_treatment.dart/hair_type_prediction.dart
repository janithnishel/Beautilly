import 'package:beautilly/data/hair_prediction_data.dart';
import 'package:beautilly/models/hair_prediction_model.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class HairTypePrediction extends StatefulWidget {
  const HairTypePrediction({super.key});

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
                                "Hair Type  Prediction",
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
                                itemCount: HairPredictionData
                                    .HairPredictionDataList.length,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final data = HairPredictionData
                                      .HairPredictionDataList[index];
                                  return _predictionResult(data);
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

  //create the single prediction result
  Widget _predictionResult(HairPredictionModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: bBlackColor,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Center(
            child: Text(
          data.Description,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: bPrimaryColor,
          ),
        )),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

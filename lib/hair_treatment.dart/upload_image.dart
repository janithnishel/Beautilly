import 'dart:collection';

import 'package:beautilly/hair_treatment.dart/hair_type_prediction.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class UploadIamge extends StatefulWidget {
  const UploadIamge({super.key});

  @override
  State<UploadIamge> createState() => _UploadIamgeState();
}

class _UploadIamgeState extends State<UploadIamge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
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
                                  const Icon(
                                    Icons.arrow_back_ios_sharp,
                                    color: bPrimaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.87,
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
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomBox(
                                  widget: ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: Image.asset(
                                      "assets/images/hair.png",
                                      fit: BoxFit.cover,
                                      width: 230,
                                      height: 290,
                                    ),
                                  ),
                                  isHaSBorder: false,
                                  width: 230,
                                  height: 290,
                                  borderRadius: 75,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomButton(
                                  title: "Upload Image",
                                  isHasMultipleWidget: false,
                                  color: bWhite.withOpacity(0.9),
                                  textColor: bBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomBox(
                                  widget: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "YOUR HAIR TYPE IS:",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: bBlackColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                            child: Text(
                                          "CURL HAIR",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: bPrimaryColor,
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                  isHaSBorder: false,
                                  height: 150,
                                  borderRadius: 20,
                                  width: MediaQuery.of(context).size.width,
                                  color: bWhite.withOpacity(0.9),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.06),
                                GestureDetector(
                                  onTap: () {
                                    
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HairTypePrediction(),));
                                  },
                                  child: CustomButton(
                                    title: "Recommended Treatments",
                                    isHasMultipleWidget: false,
                                    fontWeight: FontWeight.w500,
                                    color: bPrimaryColor.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

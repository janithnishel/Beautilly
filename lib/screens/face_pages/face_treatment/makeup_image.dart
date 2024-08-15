import 'dart:ffi';

import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/share_widget/face_page.dart';
import 'package:flutter/material.dart';

class FaceTreatmentImage extends StatelessWidget {
  const FaceTreatmentImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/targetAudience.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100,left: 15,right: 15,bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomBox(
                          isHaSBorder: false,
                          borderRadius: 70,
                          width: MediaQuery.of(context).size.width,
                          height: 275,
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: Image.asset(
                                    "assets/images/faceImage.png",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 275),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBox(
                          width: MediaQuery.of(context).size.width,
                          borderRadius: 20,
                          widget: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Face Issues :",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(
                                              0xff111111,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Fare skin",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: bGrey),
                                        ),
                                        Text(
                                          "Dark spots",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: bGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Skin type",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(
                                              0xff111111,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Oily skin",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: bGrey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Recommended  Treatments",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(
                                      0xff111111,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "IPL Therapy",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: bGrey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Duration",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(
                                      0xff111111,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Amount: Pea-sized amount, ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: bGrey),
                                ),
                                Text(
                                  "Frequency: Twice daily,",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: bGrey),
                                ),
                                Text(
                                  "Duration: 4-6 weeks",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: bGrey),
                                ),
                              ],
                            ),
                          ),
                          isHaSBorder: false,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        facePage(context),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

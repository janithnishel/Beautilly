import 'dart:ffi';
import 'dart:io';

import 'package:beautilly/data/recommended_color_data.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class MakeupSelection extends StatefulWidget {
  const MakeupSelection({super.key});

  @override
  State<MakeupSelection> createState() => _MakeupSelectionState();
}

class _MakeupSelectionState extends State<MakeupSelection> {
//create the instance to fetch the data from Recommendedcolor class

  final colorData = RecomendedColorData();

  bool isClick = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bWhite,
        elevation: 0.5,
        leading: const Icon(
          Icons.arrow_back_ios_sharp,
          size: 20,
          color: bPrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClick = true;
                      });
                    },
                    child: CustomButton(
                      title: "Bridal Makeup",
                      isHasMultipleWidget: true,
                      width: 160,
                      height: 50,
                      borderColor: isClick ? null : bPrimaryColor,
                      color: isClick ? bPrimaryLightColor : bWhite,
                      textColor: bPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      leftSideWidget: Image.asset(
                        "assets/images/facial.png",
                        color: bPrimaryColor,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClick = !true;
                      });
                    },
                    child: CustomButton(
                      title: "Normal Makeup",
                      width: 160,
                      height: 50,
                      borderColor: isClick ? bPrimaryColor : null,
                      isHasMultipleWidget: true,
                      color: isClick ? bWhite : bPrimaryLightColor,
                      textColor: bPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      leftSideWidget: Image.asset(
                        "assets/images/facial.png",
                        color: bPrimaryColor,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBox(
                width: MediaQuery.of(context).size.width,
                widget: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomBox(
                        widget: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/images/makeupImage.png",
                              fit: BoxFit.cover,
                            )),
                        isHaSBorder: false,
                        borderRadius: 50,
                        color: bPrimaryColor,
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Normal Makeup",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xff111111)),
                          ),
                          Text(
                            "Skin Tone : Fare",
                            style: TextStyle(
                              fontSize: 12,
                              color: bDarkGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Skin Type : Oily",
                            style: TextStyle(
                              fontSize: 12,
                              color: bDarkGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Lip Colour : Light pink",
                            style: TextStyle(
                              fontSize: 12,
                              color: bDarkGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                isHaSBorder: false,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Recommended Foundation colours",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: bPrimaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 95,
                child: ListView.builder(
                  itemCount: colorData.foundationColorDataList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final foundationColor = colorData.foundationColorDataList;
                    return _buildColorShape(index, foundationColor, true);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Recommended Face Powder colours",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: bPrimaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 95,
                child: ListView.builder(
                  itemCount: colorData.facePowderColorDataList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final powderColor = colorData.facePowderColorDataList;
                    return _buildColorShape(index, powderColor, true);
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Recommended Face Powder colours",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: bPrimaryColor,
                ),
              ),
              SizedBox(height: 20),
              GridView.builder(
                itemCount: colorData.lipColorDataList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio:3.6 / 2),
                itemBuilder: (context, index) {
                  final lipColor = colorData.lipColorDataList;
                  return _buildColorShape(index, lipColor, false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorShape(int index, final recommandData, bool isCircle) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          isCircle
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: recommandData[index].color),
                )
              : Container(
                  width: 70,
                  height: 25,
                  color: recommandData[index].color,
                ),
          SizedBox(
            height: 10,
          ),
          isCircle
              ? Text(
                  colorData.foundationColorDataList[index].title!,
                  style: TextStyle(
                    color: bPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text("")
        ],
      ),
    );
  }
}

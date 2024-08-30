import 'dart:ffi';
import 'dart:io';

import 'package:beautilly/data/recommended_color_data.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/utils/makeupcolour.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class MakeupSelection extends StatefulWidget {
  final String skinTone;
  final List<Map<String, String>> makeupSuggestions;

  const MakeupSelection({
    Key? key,
    required this.skinTone,
    required this.makeupSuggestions,
  }) : super(key: key);

  @override
  State<MakeupSelection> createState() => _MakeupSelectionState();
}

class _MakeupSelectionState extends State<MakeupSelection> {
  bool isBridalMakeupSelected = true;

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
                        isBridalMakeupSelected = true;
                      });
                    },
                    child: CustomButton(
                      title: "Bridal Makeup",
                      isHasMultipleWidget: true,
                      width: 160,
                      height: 50,
                      borderColor: isBridalMakeupSelected ? null : bPrimaryColor,
                      color: isBridalMakeupSelected ? bPrimaryLightColor : bWhite,
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
                        isBridalMakeupSelected = false;
                      });
                    },
                    child: CustomButton(
                      title: "Normal Makeup",
                      width: 160,
                      height: 50,
                      borderColor: isBridalMakeupSelected ? bPrimaryColor : null,
                      isHasMultipleWidget: true,
                      color: isBridalMakeupSelected ? bWhite : bPrimaryLightColor,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Normal Makeup",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xff111111)),
                          ),
                          Text(
                            "Skin Tone : ${widget.skinTone}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: bDarkGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Makeup Type : ${isBridalMakeupSelected ? 'Bridal' : 'Normal'}",
                            style: const TextStyle(
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
              const SizedBox(
                height: 20,
              ),
              _buildColorRecommendation("Foundation", "Foundation"),
              const SizedBox(
                height: 20,
              ),
              _buildColorRecommendation("Concealer", "Concealer"),
              const SizedBox(
                height: 20,
              ),
              _buildColorRecommendation("Blush", "Blush"),
              const SizedBox(
                height: 20,
              ),
              _buildColorRecommendation("Lipstick", "Lipstick"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorRecommendation(String title, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended $title colors",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: bPrimaryColor,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 95,
          child: ListView.builder(
            itemCount: widget.makeupSuggestions.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final colorItem = widget.makeupSuggestions[index];
              return _buildColorShape(colorItem[key], isCircle: true);
            },
          ),
        ),
      ],
    );
  }

Widget _buildColorShape(String? colorName, {required bool isCircle}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Column(
      children: [
        Container(
          width: isCircle ? 60 : 70,
          height: isCircle ? 60 : 25,
          decoration: BoxDecoration(
            borderRadius: isCircle ? BorderRadius.circular(50) : null,
            color: _getColorFromName(colorName ?? 'Unknown'),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        isCircle
            ? Text(
                colorName ?? 'Unknown',
                style: const TextStyle(
                  color: bPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const Text(""),
      ],
    ),
  );
}

  Color _getColorFromName(String colorName) {
    return colorMapping[colorName.toLowerCase()] ?? Colors.grey;
  }
}

import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:beautilly/widget/custom_dropdown_button.dart';
import 'package:flutter/material.dart';

class AddPreference extends StatefulWidget {
  const AddPreference({super.key});

  @override
  State<AddPreference> createState() => _AddPreferenceState();
}

int isSelected = 99;

class _AddPreferenceState extends State<AddPreference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/preferencePage.png",
                  fit: BoxFit.cover,
            
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/backArrow.png",
                          fit: BoxFit.cover,
                          color: bPrimaryColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Enter Your  Peferences",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff111111),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      title: "Age",
                      isHasMultipleWidget: true,
                      rightSideImage: CustomDropdownButton(
                        dropdownItems: ["18-24", "25-34", "35-44", "45-54"],
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Gender",
                      isHasMultipleWidget: true,
                      rightSideImage: CustomDropdownButton(
                        dropdownItems: ["Male", "Female"],
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "IncomeLevel",
                      isHasMultipleWidget: true,
                      rightSideImage: CustomDropdownButton(
                        dropdownItems: ["Low", "Middle", "High"],
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Colour Scheme",
                      isHasMultipleWidget: true,
                      rightSideImage: Image.asset(
                        "assets/images/uploadImage.png",
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Decor Style",
                      isHasMultipleWidget: true,
                      rightSideImage: Image.asset(
                        "assets/images/uploadImage.png",
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Lightning",
                      isHasMultipleWidget: true,
                      rightSideImage: Image.asset(
                        "assets/images/uploadImage.png",
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Furniture",
                      isHasMultipleWidget: true,
                      rightSideImage: Image.asset(
                        "assets/images/uploadImage.png",
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "StylingStation",
                      isHasMultipleWidget: true,
                      rightSideImage: Image.asset(
                        "assets/images/uploadImage.png",
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "WashingStation",
                      isHasMultipleWidget: true,
                      rightSideImage: Image.asset(
                        "assets/images/uploadImage.png",
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Waiting Area",
                      isHasMultipleWidget: true,
                      rightSideImage: Image.asset(
                        "assets/images/uploadImage.png",
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = 0;
                            });
                          },
                          child: CustomButton(
                            title: "Cancel",
                            isHasMultipleWidget: false,
                            width: 150,
                            fontWeight: FontWeight.w600,
                            color: isSelected == 0 ? bPrimaryColor : bWhite,
                            textColor: isSelected == 0 ? bWhite : bBlackColor,
                            borderColor:
                                isSelected == 0 ? null : bPrimaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = 1;
                            });
                          },
                          child: CustomButton(
                            title: "Submit",
                            isHasMultipleWidget: false,
                            width: 150,
                            fontWeight: FontWeight.w600,
                            color: isSelected == 1 ? bPrimaryColor : bWhite,
                            textColor: isSelected == 1 ? bWhite : bBlackColor,
                            borderColor:
                                isSelected == 1 ? null : bPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //     width: double.infinity,
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //       color: bWhite,
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("Age"),
                    //         DropdownButton(
                    //           value:_setValues ,
                    //           items: ageData.map((data) {
                    //             return DropdownMenuItem(
                    //                 value: data, child: Text(data));
                    //           }).toList(),
                    //           onChanged: (value) {
                    //             setState(() {
                    //               _setValues = value!;
                    //             });
                    //           },
                    //         )
                    //       ],
                    //     ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

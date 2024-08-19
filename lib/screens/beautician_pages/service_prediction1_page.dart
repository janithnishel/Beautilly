import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:beautilly/widget/custom_dropdown_button.dart';
import 'package:flutter/material.dart';

class ServicePrediction extends StatefulWidget {
  const ServicePrediction({super.key});

  @override
  State<ServicePrediction> createState() => _ServicePredictionState();
}

class _ServicePredictionState extends State<ServicePrediction> {
  int isClick = 99;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bWhite,
        titleSpacing: -15,
        elevation: 0.5,
        title: const Text(
          "Service Prediction Results",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: bBlackColor,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: bBlackColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Top 3 Recommended \nBeauticians",
                    style: TextStyle(
                        color: bBlackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: CustomBox(
                        width: 80,
                        height: 25,
                        borderRadius: 4,
                        blurRadius: 0,
                        shadowColor: Colors.transparent,
                        shadowOfset: Offset(0, 0),
                        borderWidth: 1,
                        BorderColor: bBlackColor,
                        widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "View All",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: bBlackColor,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 12,
                                color: bBlackColor,
                              )
                            ],
                          ),
                        ),
                        isHaSBorder: true),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CustomBox(
                    widget: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          "assets/images/user.png",
                          fit: BoxFit.cover,
                        )),
                    isHaSBorder: false,
                    blurRadius: 0,
                    borderRadius: 40,
                    borderWidth: 0,
                    BorderColor: Colors.transparent,
                    height: 40,
                    width: 40,
                    color: bLowLightGrey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Staff Member 1",
                    style: TextStyle(
                      color: bBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClick = 0;
                      });
                    },
                    child: _clickableButton("Quick",0),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isClick = 1;
                        });
                      },
                      child: _clickableButton("Friendly",1)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: CustomBox(
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/beautician6.png",
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 60,
                          height: 25,
                          decoration: BoxDecoration(
                            color: bLowLightGrey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              "4.5 stars",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: bBlackColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Senior Hairdresser",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: bBlackColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Salon name",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: bBlackColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Distance: 1.5km",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: bBlackColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  isHaSBorder: false,
                  borderRadius: 6,
                  shadowOfset: const Offset(0, 4),
                  blurRadius: 4,
                  height: MediaQuery.of(context).size.height * 0.47,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _clickableButton(String title,int index) {
    return CustomButton(
      title: title,
      isHasMultipleWidget: false,
      color: isClick==index?bPrimaryColor: bLowLightGrey,
      radius: 6,
      width: 160,
      height: 36,
      textColor:isClick==index?bWhite: bBlackColor,
      fontSize: 14,
    );
  }
}

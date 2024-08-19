import 'dart:math';

import 'package:beautilly/data/service_data.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  //Check whether which button was cliked
  int isClick = 0;

  // fetching service data from Srvice data model
  final serviceData = ServiceData().serviceDataList;

  //Create the Service button title data list
  double _currentSliderValue = 0;
  final List<String> serviceButtonDataList = [
    "All",
    "Women",
    "Men",
    "Kids",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: bPrimaryColor,
                    ),
                  ),
                  Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: bBlackColor,
                    ),
                  ),
                  Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: bAccentRedColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              const Text(
                "Available on",
                style: TextStyle(
                  color: bBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(
                height: 20,
              ),
              const Text(
                "Service",
                style: TextStyle(
                  color: bBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 135,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  itemCount: serviceData.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // childAspectRatio: 3 / 1,
                      mainAxisExtent: 30,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return CustomButton(
                      title: serviceData[index].title,
                      isHasMultipleWidget: false,
                      color: bWhite,
                      textColor: bBlackColor,
                      borderColor: bGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    );
                  },
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              const Text(
                "Rating",
                style: TextStyle(
                  color: bBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.star,
                        color:
                            i == 4 ? bGrey.withOpacity(0.2) : bSecondaryColor,
                        size: 25,
                      ),
                    ),
                  const Text(
                    "4 Star",
                    style: TextStyle(
                      color: bPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Service for",
                style: TextStyle(
                  color: bBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [for (int i = 0; i < 4; i++) _serviceButton(i)],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Distance",
                style: TextStyle(
                  color: bBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Slider(
                value: _currentSliderValue,
                min: 0,
                thumbColor: bPrimaryColor,
                max: 100,
                allowedInteraction: SliderInteraction.tapAndSlide,
                divisions: 100,
                label: _currentSliderValue.round().toString() + ' km',
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
                activeColor: bPrimaryColor,
                inactiveColor: Colors.grey[300],
                onChangeEnd: (value) {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "0 km",
                      style: TextStyle(
                          color: bGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "100 km",
                      style: TextStyle(
                          color: bGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              const CustomButton(
                title: "Show Result",
                isHasMultipleWidget: false,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
        ),
      ),
    );
  }

//create a single button
  Widget _serviceButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClick = index;

          print(isClick);
        });
      },
      child: CustomButton(
        title: serviceButtonDataList[index],
        isHasMultipleWidget: false,
        color: isClick == index ? bPrimaryLightColor : bWhite,
        textColor: bBlackColor,
        borderColor: isClick == index ? bPrimaryColor : bGrey,
        fontSize: 12,
        width: 75,
        height: 30,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

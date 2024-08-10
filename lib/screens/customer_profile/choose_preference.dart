import 'package:beautilly/screens/join_page.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ChoosePreference extends StatefulWidget {
  const ChoosePreference({super.key});

  @override
  State<ChoosePreference> createState() => _ChoosePreferenceState();
}

class _ChoosePreferenceState extends State<ChoosePreference> {
  double borderRadius = 5;
  double width = 0.14;
  double height = 0.06;
  final PageController _pageconrol = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageconrol.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: bhightLightGrey,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          GlobalUser.profileUrl ?? "assets/images/user.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${GlobalUser.firstName ?? 'User'}",
                          style: const TextStyle(
                              color: Color(0xff111111),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 1),
                        ),
                        Text(
                          "Choose Your Preferences",
                          style: TextStyle(
                            color: bGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Style Orientation ",
                  style: TextStyle(
                    color: bBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Modern",
                      width: MediaQuery.of(context).size.height * width,
                      radius: borderRadius,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Natural",
                      radius: borderRadius,
                      width: MediaQuery.of(context).size.height * width,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Traditional",
                      radius: borderRadius,
                      width: MediaQuery.of(context).size.height * width,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Select your preferred style",
                  style: TextStyle(
                    color: bGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Beautician Interaction Style",
                  style: TextStyle(
                    color: bBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Conversational",
                      width: MediaQuery.of(context).size.height * 0.18,
                      radius: borderRadius,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Quiet",
                      radius: borderRadius,
                      width: MediaQuery.of(context).size.height * 0.1,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Informative",
                      radius: borderRadius,
                      width: MediaQuery.of(context).size.height * 0.14,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                CustomButton(
                  isHasMultipleWidget: false,
                  title: "Supportive",
                  radius: borderRadius,
                  width: MediaQuery.of(context).size.height * 0.14,
                  height: MediaQuery.of(context).size.height * height,
                  textColor: bBlackColor,
                  color: bLowLightGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Choose how you prefer to interact",
                  style: TextStyle(
                    color: bGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Speed of Service",
                  style: TextStyle(
                    color: bBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Quick",
                      width: MediaQuery.of(context).size.height * 0.217,
                      radius: borderRadius,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Thorough",
                      radius: borderRadius,
                      width: MediaQuery.of(context).size.height * 0.217,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Select your desired speed",
                  style: TextStyle(
                    color: bGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Beautician Personality Type",
                  style: TextStyle(
                    color: bBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Cheerful",
                      width: MediaQuery.of(context).size.height * 0.217,
                      radius: borderRadius,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Professional",
                      radius: borderRadius,
                      width: MediaQuery.of(context).size.height * 0.217,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Friendly",
                      width: MediaQuery.of(context).size.height * 0.217,
                      radius: borderRadius,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "Disciplined",
                      radius: borderRadius,
                      width: MediaQuery.of(context).size.height * 0.217,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Choose your personality style",
                  style: TextStyle(
                    color: bGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Average Time ",
                  style: TextStyle(
                    color: bBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "0 - 30 min",
                      width: MediaQuery.of(context).size.height * width,
                      radius: borderRadius,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "0 - 45 min",
                      radius: borderRadius,
                      width: MediaQuery.of(context).size.height * width,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      isHasMultipleWidget: false,
                      title: "0 - 1 H",
                      radius: borderRadius,
                      width: MediaQuery.of(context).size.height * width,
                      height: MediaQuery.of(context).size.height * height,
                      textColor: bBlackColor,
                      color: bLowLightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Choose your personality style",
                  style: TextStyle(
                    color: bGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: bBlackColor.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: CustomButton(
                        isHasMultipleWidget: false,
                        title: "Reset",
                        width: MediaQuery.of(context).size.height * 0.217,
                        radius: borderRadius,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: bBlackColor,
                        color: bWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        borderColor: bBlackColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: bBlackColor.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: CustomButton(
                        isHasMultipleWidget: false,
                        title: "Submit",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * 0.217,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: bWhite,
                        color: bPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bLowLightGrey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 200,
                  child: Stack(
                    children: [
                      PageView(
                        controller: _pageconrol,
                        children: [
                          //load the relevant pages
                          const Center(
                              child: Text("Explore Our Recommendations")),
                          Container(
                            child: const Center(
                                child: Text("Explore Our Recommendations")),
                          ),
                          Container(
                            child: const Center(
                                child: Text("Explore Our Recommendations")),
                          ),
                          Container(
                            child: const Center(
                                child: Text("Explore Our Recommendations")),
                          ),
                        ],
                      ),
                      Container(
                        alignment: const Alignment(0, 0.9),
                        child: SmoothPageIndicator(
                          controller: _pageconrol,
                          count: 4,
                          effect: const ExpandingDotsEffect(
                            dotColor: Colors.grey,
                            activeDotColor: bWhite,
                            dotWidth: 4,
                            dotHeight: 4,
                            expansionFactor: 5.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:beautilly/screens/customer_profile/findservice_page.dart';
import 'package:beautilly/utils/GlobalUser.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ChoosePreference extends StatefulWidget {
  const ChoosePreference({super.key});

  @override
  State<ChoosePreference> createState() => _ChoosePreferenceState();
}

class _ChoosePreferenceState extends State<ChoosePreference> {
  double borderRadius = 5;
  double width = 0.14;
  double height = 0.06;
  // Handle submit button and reset color
  int isSelected = 99;
  // Initializing initial value for all the buttons
  int section1 = 99;
  int section2 = 99;
  int section3 = 99;
  int section4 = 99;
  int section5 = 99;
  final PageController _pageconrol = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageconrol.dispose();
  }

  Future<void> _submitPreferences() async {
    try {
      int? customerId = GlobalUser.customerId;

      if (customerId == null) {
        throw Exception("Customer ID is null");
      }

      final url = Uri.parse('http://10.0.2.2:8001/preferences/');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Style_Orientation': section1 == 0
              ? 'Modern'
              : section1 == 1
                  ? 'Natural'
                  : section1 == 2
                      ? 'Traditional'
                      : 'Unknown',
          'Speed_of_Service': section3 == 0 ? 'Quick' : 'Thorough',
          'Beautician_Interaction_Style': section2 == 0
              ? 'Conversational'
              : section2 == 1
                  ? 'Quiet'
                  : section2 == 2
                      ? 'Informative'
                      : 'Supportive',
          'Beautician_Personality_Type': section4 == 0
              ? 'Cheerful'
              : section4 == 1
                  ? 'Professional'
                  : section4 == 2
                      ? 'Friendly'
                      : 'Disciplined',
          'Average_Time': section5 == 0
              ? '0 - 30 min'
              : section5 == 1
                  ? '0 - 45 min'
                  : section5 == 2
                      ? '0 - 1 H'
                      : 'Unknown',
          'Customer_ID': customerId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show a success toast message
        Fluttertoast.showToast(
          msg: "Preferences submitted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        // Navigate to FindService page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FindService()),
        );
      } else {
        print('Failed to submit preferences: ${response.statusCode}');
        // Show an error toast message
        Fluttertoast.showToast(
          msg: "Failed to submit preferences",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('Error submitting preferences: $e');
      // Show an error toast message
      Fluttertoast.showToast(
        msg: "Error submitting preferences",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section1 = 0;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Modern",
                        width: MediaQuery.of(context).size.height * width,
                        radius: borderRadius,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section1 == 0 ? bWhite : bBlackColor,
                        color: section1 == 0 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section1 = 1;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Natural",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * width,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section1 == 1 ? bWhite : bBlackColor,
                        color: section1 == 1 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section1 = 2;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Traditional",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * width,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section1 == 2 ? bWhite : bBlackColor,
                        color: section1 == 2 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section2 = 0;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Conversational",
                        width: MediaQuery.of(context).size.height * 0.18,
                        radius: borderRadius,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section2 == 0 ? bWhite : bBlackColor,
                        color: section2 == 0 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section2 = 1;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Quiet",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * 0.1,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section2 == 1 ? bWhite : bBlackColor,
                        color: section2 == 1 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section2 = 2;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Informative",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * 0.14,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section2 == 2 ? bWhite : bBlackColor,
                        color: section2 == 2 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      section2 = 3;
                    });
                  },
                  child: CustomButton(
                    
                    isHasMultipleWidget: false,
                    title: "Supportive",
                    radius: borderRadius,
                    width: MediaQuery.of(context).size.height * 0.14,
                    height: MediaQuery.of(context).size.height * height,
                    textColor: section2 == 3 ? bWhite : bBlackColor,
                    color: section2 == 3 ? bPrimaryColor : bLowLightGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section3 = 0;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Quick",
                        width: MediaQuery.of(context).size.height * 0.217,
                        radius: borderRadius,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section3 == 0 ? bWhite : bBlackColor,
                        color: section3 == 0 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section3 = 1;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Thorough",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * 0.217,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section3 == 1 ? bWhite : bBlackColor,
                        color: section3 == 1 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section4 = 0;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Cheerful",
                        width: MediaQuery.of(context).size.height * 0.217,
                        radius: borderRadius,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section4 == 0 ? bWhite : bBlackColor,
                        color: section4 == 0 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section4 = 1;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Professional",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * 0.217,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section4 == 1 ? bWhite : bBlackColor,
                        color: section4 == 1 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section4 = 2;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Friendly",
                        width: MediaQuery.of(context).size.height * 0.217,
                        radius: borderRadius,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section4 == 2 ? bWhite : bBlackColor,
                        color: section4 == 2 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section4 = 3;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "Disciplined",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * 0.217,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section4 == 3 ? bWhite : bBlackColor,
                        color: section4 == 3 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section5 = 0;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "0 - 30 min",
                        width: MediaQuery.of(context).size.height * width,
                        radius: borderRadius,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section5 == 0 ? bWhite : bBlackColor,
                        color: section5 == 0 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section5 = 1;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "0 - 45 min",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * width,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section5 == 1 ? bWhite : bBlackColor,
                        color: section5 == 1 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          section5 = 2;
                        });
                      },
                      child: CustomButton(
                        
                        isHasMultipleWidget: false,
                        title: "0 - 1 H",
                        radius: borderRadius,
                        width: MediaQuery.of(context).size.height * width,
                        height: MediaQuery.of(context).size.height * height,
                        textColor: section5 == 2 ? bWhite : bBlackColor,
                        color: section5 == 2 ? bPrimaryColor : bLowLightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Choose your average time",
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
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = 0;
                            section1 = 99;
                            section2 = 99;
                            section3 = 99;
                            section4 = 99;
                            section5 = 99;
                          });
                        },
                        child: CustomButton(
                          
                          isHasMultipleWidget: false,
                          title: "Reset",
                          width: MediaQuery.of(context).size.height * 0.217,
                          radius: borderRadius,
                          height: MediaQuery.of(context).size.height * height,
                          textColor: isSelected == 0 ? bWhite : bBlackColor,
                          color: isSelected == 0 ? bPrimaryColor : bWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          borderColor: isSelected == 0 ? null : bBlackColor,
                        ),
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
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isSelected = 1;
                          });
                          await _submitPreferences(); // Submit preferences to the API
                        },
                        child: CustomButton(
                          
                          isHasMultipleWidget: false,
                          title: "Submit",
                          radius: borderRadius,
                          width: MediaQuery.of(context).size.height * 0.217,
                          height: MediaQuery.of(context).size.height * height,
                          textColor: isSelected == 1 ? bWhite : bBlackColor,
                          color: isSelected == 1 ? bPrimaryColor : bWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          borderColor: isSelected == 1 ? null : bBlackColor,
                        ),
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
                          // Load the relevant pages
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

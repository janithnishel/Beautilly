import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class SimilarGroup extends StatelessWidget {
  const SimilarGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: bPrimaryColor,
          size: 20,
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                bPrimaryColor.withOpacity(0.3),
                bPrimaryColor.withOpacity(0.126),
                bPrimaryColor.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomButton(
                title: "Demographics",
                isHasMultipleWidget: false,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/images/image_22.png", // Replace with your correct image name
                      height: 50,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "18-24",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/images/image_23.png", // Replace with your correct image name
                      height: 50,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Female",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/images/image_24.png", // Replace with your correct image name
                      height: 50,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "High",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomButton(
                title: "Preferences",
                isHasMultipleWidget: false,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/images/Monocromatic.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Image.asset(
                      "assets/images/Accent.png",
                      fit: BoxFit.cover,
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

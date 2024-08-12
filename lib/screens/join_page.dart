import 'package:beautilly/data/onboarding_data.dart';
import 'package:beautilly/screens/onboarding/shared_onboarding.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  JoinPage({super.key});

//fetch data from OnBoardingData class
  final data = OnboardingData().onBoardingListData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SharedScreen(
              fontsize: 20,
              bottomPadding: 265,
              title: data[3].title,
              image: data[3].imageUrl,
              description: data[3].description,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 170,
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(isHasMultipleWidget: true,
                
                    title: "Join with Google",
                    color: bWhite,
                    textColor: bPrimaryColor,
                    leftSideWidget: Image.asset(
                      "assets/images/googleIcon.png",
                      fit: BoxFit.cover,
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 105,
              child: GestureDetector(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(isHasMultipleWidget: true,
               
                    title: "Join with Email",
                    leftSideWidget: Icon(
                      Icons.email,
                      color: bWhite,
                      size: 15,

                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: const Alignment(0, 0.85),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: bWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: bSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

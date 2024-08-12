import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:beautilly/data/onboarding_data.dart';
import 'package:beautilly/screens/join_page.dart';
import 'package:beautilly/screens/onboarding/shared_onboarding.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
// create the instance of onboarding data class for fetch the onscreeen data
  final onBoardingData = OnboardingData().onBoardingListData;
  //craete page controller
  final PageController _pageconrol = PageController();
  bool isHasPage = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageconrol.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    controller: _pageconrol,
                    onPageChanged: (page) {
                      setState(
                        () {
                          isHasPage = page == 2;
                        },
                      );
                    },
                    children: [
                      SharedScreen(
                        title: onBoardingData[0].title,
                        image: onBoardingData[0].imageUrl,
                        description: onBoardingData[0].description,
                      ),
                      SharedScreen(
                        title: onBoardingData[1].title,
                        image: onBoardingData[1].imageUrl,
                        description: onBoardingData[1].description,
                      ),
                      SharedScreen(
                        title: onBoardingData[2].title,
                        image: onBoardingData[2].imageUrl,
                        description: onBoardingData[2].description,
                      ),
                    ],
                  ),
                  Container(
                    alignment: const Alignment(0, 0.5),
                    child: SmoothPageIndicator(
                      controller: _pageconrol,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                          dotColor: bWhite,
                          activeDotColor: bSecondaryColor,
                          dotWidth: 8,
                          dotHeight: 8,
                          expansionFactor: 4),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 92,
                    child: !isHasPage
                        ? GestureDetector(
                            onTap: () {
                              _pageconrol.animateToPage(
                                _pageconrol.page!.toInt() + 1,
                                duration: const Duration(microseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: CustomButton(
                           
                                  title: 'Next', isHasMultipleWidget: false),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JoinPage(),
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: CustomButton(
                         
                                  isHasMultipleWidget: false,
                                  title: isHasPage ? 'Get Started' : 'Next'),
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
          ],
        ),
      ),
    );
  }
}

import 'package:beautilly/data/comment_card_data.dart';
import 'package:beautilly/models/comment_card.dart';
import 'package:beautilly/screens/beautician_pages/appbar.dart/appbar.dart';
import 'package:beautilly/screens/beautician_pages/staff_member_profile.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:beautilly/widget/share_widget/comment_card.dart';

import 'package:beautilly/widget/share_widget/share_custom_textield.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddReview extends StatefulWidget {
  const AddReview({super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  // fetch the data from comment data class

  final commentData = CommentCardData().commentDataList;

  //no of pages using the page view

  int _pageCount = 4;

  //create the  instance of page controller

  PageController _control = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    _control.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bWhite,
      appBar: appBar("Add Reviews",context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add your review",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                isHasHintText: true,
                isHasssuffixIcon: false,
                isHasPrefixIcon: false,
                hintText: "Write your feedback here",
                hintTextColor: bBlackColor.withOpacity(0.5),
                fillColor: bWhite,
                enableBorderRadius: 6,
                foccusBorderRadius: 6,
                hintTextFw: FontWeight.w400,
                enableBorderColor: bBlackColor.withOpacity(0.1),
                foccusBorderColor: bBlackColor.withOpacity(0.1),
                horizontalPadding: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Attach an image if you like",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomBox(
                widget: Expanded(
                  child: Stack(
                    children: [
                      PageView(
                        controller: _control,
                        children: [
                          for (int i = 1; i <= _pageCount; i++)
                            Container(
                              child: Center(
                                child: Text(
                                  "Uplode Image",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SmoothPageIndicator(
                                  controller: _control,
                                  count: _pageCount,
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
                        ],
                      )
                    ],
                  ),
                ),
                isHaSBorder: false,
                color: bLowLightGrey,
                width: MediaQuery.of(context).size.width,
                height: 150,
                borderRadius: 6,
                blurRadius: 0,
                shadowColor: Colors.transparent,
                shadowOfset: Offset(0, 0),
              ),
                 SizedBox(
                height: 10,
              ),
              CustomButton(
                title: "Submit",
                isHasMultipleWidget: false,
                fontWeight: FontWeight.w500,
                textColor: bWhite,
                radius: 8,
                color: bBlackColor,
                borderColor: bBlackColor,
              ),
           
              SizedBox(
                height: 25,
              ),
              const Text(
                "Reviews",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: bBlackColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: commentData.length,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    CommentCardModel data = commentData[index];
                    return commentCard(data, index, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
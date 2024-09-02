import 'package:flutter/material.dart';
import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/models/comment_card.dart';
import 'package:beautilly/screens/beautician_pages/appbar.dart/appbar.dart';
import 'package:beautilly/utils/GlobalUser.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:beautilly/widget/custom_textform_field.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddReview extends StatefulWidget {
  final int beauticianId;

  const AddReview({super.key, required this.beauticianId});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  PageController _control = PageController();
  int _pageCount = 4;

  @override
  void dispose() {
    _commentController.dispose();
    _ratingController.dispose();
    _control.dispose();
    super.dispose();
  }

  void _submitReview() async {
    String comment = _commentController.text;
    int rating = int.tryParse(_ratingController.text) ?? 0;
    String image = "https://example.com/image.jpg"; // Placeholder for image URL
    int? customerId = GlobalUser.customerId; // Use GlobalUser to get the customer ID

    if (customerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Customer ID is not available')),
      );
      return;
    }

    Map<String, dynamic> reviewData = {
      "Comment": comment,
      "Rating": rating,
      "Image": image,
      "Customer_ID": customerId,
      "Beautician_ID": widget.beauticianId,
    };

    try {
      await ApiService.postReview(reviewData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully!')),
      );
      // Optionally, you can clear the input fields after submission
      _commentController.clear();
      _ratingController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bWhite,
      appBar: appBar("Add Reviews", context),
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
              CustomTextFormField(
                controller: _commentController,
                suffix: null,
                title: "Comment: ",
                inputType: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: _ratingController,
                suffix: null,
                title: "Rating: ",
                inputType: TextInputType.number,
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
                                  "Upload Image",
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
                onTap: _submitReview,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:beautilly/data/comment_card_data.dart';
import 'package:beautilly/models/comment_card.dart';
import 'package:beautilly/screens/beautician_pages/add_review.dart';
import 'package:beautilly/screens/beautician_pages/schedule_appointment.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:beautilly/widget/share_widget/comment_card.dart';

import 'package:flutter/material.dart';

class StaffMemberProfile extends StatefulWidget {
  const StaffMemberProfile({super.key});

  @override
  State<StaffMemberProfile> createState() => _StaffMemberProfileState();
}

class _StaffMemberProfileState extends State<StaffMemberProfile> {
  //initialized the index for tracking tapped button

  int _onClick = 99;
  // fetch the data from comment data class

  final commentData = CommentCardData().commentDataList;

  int isTap = 99;
  int isThumbsUp = 99;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bWhite,
        appBar: AppBar(
          backgroundColor: bWhite,
          leading: const Icon(
            Icons.arrow_back_ios_sharp,
            size: 20,
            color: bBlackColor,
          ),
          elevation: 3,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: bhightLightGrey),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sarah De Silva",
                          style: TextStyle(
                            color: bBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Saloon Staff",
                          style: TextStyle(
                            color: bGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _profileServiceCard(
                          "assets/images/hair.png", "Work Images"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Services Offered",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: bBlackColor,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Facials, Makeup, Waxing, etc.",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: bBlackColor,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: bBlackColor,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "123 Beauty Street, CityABC",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: bBlackColor,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Reviews",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: bBlackColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: bhightLightGrey),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/availability.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Availability",
                          style: TextStyle(
                            color: bBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Monday - Saturday",
                          style: TextStyle(
                            color: bGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                for (int i = 0; i < 2; i++)
                  Padding(
                    padding: i == 0
                        ? const EdgeInsets.only(bottom: 5)
                        : const EdgeInsets.only(top: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _onClick = i;
                        });

                        if (_onClick == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScheduleAppointment(),
                              ));
                        } else if (_onClick == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddReview(),
                            ),
                          );
                        }
                      },
                      child: CustomButton(
                        title: i == 0
                            ? "Schedule Appointment"
                            : "Add New Feedback",
                        isHasMultipleWidget: false,
                        fontWeight: FontWeight.w500,
                        textColor: _onClick == i ? bWhite : bBlackColor,
                        radius: 8,
                        color: _onClick == i ? bBlackColor : bWhite,
                        borderColor: _onClick == i ? null : bBlackColor,
                        strokWidth: _onClick == i ? 0 : 1.5,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _profileServiceCard(String imageUrl, String title) {
    return CustomBox(
      widget: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: bBlackColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
      isHaSBorder: true,
      height: MediaQuery.of(context).size.height * 0.25,
      BorderColor: bhightLightGrey,
      borderWidth: 1,
      borderRadius: 10,
      blurRadius: 0,
      shadowColor: Colors.transparent,
      shadowOfset: const Offset(0, 0),
    );
  }
}
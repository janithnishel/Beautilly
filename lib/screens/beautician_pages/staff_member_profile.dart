import 'package:beautilly/data/comment_card_data.dart';
import 'package:beautilly/models/comment_card.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:flutter/material.dart';

class StaffMemberProfile extends StatefulWidget {
  const StaffMemberProfile({super.key});

  @override
  State<StaffMemberProfile> createState() => _StaffMemberProfileState();
}

class _StaffMemberProfileState extends State<StaffMemberProfile> {
  // fetch the data from comment data class

  final commentData = CommentCardData().commentDataList;

  int isTap = 99;
  int isThumbsUp = 99;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bWhite,
          leading: const Icon(
            Icons.arrow_back_ios_sharp,
            size: 20,
            color: bBlackColor,
          ),
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
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
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: CustomBox(
                          width: 100,
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
                                  "View Profile",
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: _ProfileServiceCard(
                            "assets/images/hair.png", "Cut & Color")),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: _ProfileServiceCard(
                            "assets/images/nail.png", "Nail Art"))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomBox(
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: bLowLightGrey),
                            child: Center(
                              child: Image.asset(
                                "assets/images/review.png",
                                fit: BoxFit.cover,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                          Text(
                            "Add Review Post",
                            style: TextStyle(
                                color: bBlackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      isHaSBorder: true,
                      height: MediaQuery.of(context).size.height * 0.125,
                      width: MediaQuery.of(context).size.width * 0.45,
                      borderRadius: 10,
                      borderWidth: 1,
                      BorderColor: bhightLightGrey,
                      shadowColor: Colors.transparent,
                      blurRadius: 0,
                      shadowOfset: Offset(0, 0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: ListView.builder(
                    itemCount: commentData.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      CommentCardModel data = commentData[index];
                      return _commentCard(data ,index);
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                ])
              ],
            ),
          ),
        ));
  }

  Widget _ProfileServiceCard(String imageUrl, String title) {
    return CustomBox(
      widget: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
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
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
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
    );
  }

  Widget _commentCard(CommentCardModel data ,int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CustomBox(
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: bLowLightGrey),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          data.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data.customerName,
                    style: TextStyle(
                      color: bBlackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  for (int i = 0; i < 5; i++)
                    Icon(
                      Icons.star,
                      size: 15,color: data.starCount>i?Color(0xffFFC700):bhightLightGrey
                    )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data.comment,
                style: TextStyle(
                  color: bBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      
                      setState(() {
                        
                       isTap =index;
                       isThumbsUp = 0;



                      });
                    },
                    child: Image.asset(
                      "assets/images/thumbs_up.png",
                      fit: BoxFit.cover,
                      width: isTap==index?isThumbsUp==0?25:20:20
                      ,
                      height: isTap==index?isThumbsUp==0?25:20:20
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      

                      setState(() {
                        
                         isTap =index;
                       isThumbsUp = 1;
                      });
                    },
                    child: Image.asset(
                      "assets/images/thumbs_down.png",
                      fit: BoxFit.cover,
                      width:  isTap==index?isThumbsUp==1?25:20:20,
                      height:  isTap==index?isThumbsUp==1?25:20:20
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        isHaSBorder: true,
        // height: MediaQuery.of(context).size.height * 0.04,
        width: MediaQuery.of(context).size.width * 0.75,
        borderRadius: 10,
        borderWidth: 1,
        BorderColor: bhightLightGrey,
        shadowColor: Colors.transparent,
        blurRadius: 0,
        shadowOfset: Offset(0, 0),
        color: bLowLightGrey,
      ),
    );
  }
}

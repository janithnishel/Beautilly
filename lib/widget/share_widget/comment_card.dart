import 'package:beautilly/models/comment_card.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:flutter/material.dart';

 Widget commentCard(CommentCardModel data, int index, context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CustomBox(
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
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
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            data.customerName,
                            style: const TextStyle(
                              color: bBlackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          for (int i = 0; i < 5; i++)
                            Icon(Icons.star,
                                size: 15,
                                color: data.starCount > i
                                    ? const Color(0xffFFC700)
                                    : bhightLightGrey)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        data.comment,
                        style: const TextStyle(
                          color: bBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/images/hair.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        isHaSBorder: true,
        // height: MediaQuery.of(context).size.height * 0.04,
        width: MediaQuery.of(context).size.width * 0.65,
        borderRadius: 10,
        borderWidth: 1,
        BorderColor: bhightLightGrey,
        shadowColor: Colors.transparent,
        blurRadius: 0,
        shadowOfset: const Offset(0, 0),
        color: bLowLightGrey,
      ),
    );
  }
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:flutter/material.dart';

Widget facePage(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomBox(
        height: 50,
        widget: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: bPrimaryColor,
          ),
        ),
        isHaSBorder: false,
        width: 50,
        borderRadius: 50,
        color: const Color(0xffF9FAFA).withOpacity(0.6),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.42,
      ),
      CustomBox(
        height: 50,
        widget: const Center(
          child: Icon(
            Icons.favorite_border_rounded,
            size: 25,
            color: bAccentRedColor,
          ),
        ),
        isHaSBorder: false,
        width: 50,
        borderRadius: 50,
        color: const Color(0xffF9FAFA).withOpacity(0.6),
      ),
      CustomBox(
        height: 50,
        widget: Center(
            child: Image.asset(
          "assets/images/map.png",
          fit: BoxFit.cover,width: 25,height: 20,
        )),
        isHaSBorder: false,
        width: 50,
        borderRadius: 50,
        color: const Color(0xffF9FAFA).withOpacity(0.6),
      ),
    ],
  );
}

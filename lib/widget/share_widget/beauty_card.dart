import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget beautyCard(
    {String? title = "",
    required String description,
    required imageUrl,
    required BuildContext context,
    required index}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: CustomBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.32,
        widget: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: bPrimaryColor),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff111111)),
                  ),
                  Center(
                    child: Image.asset(
                      imageUrl,
                      // color: imageColor,
                      fit: BoxFit.cover,
                      width: index == 0 ? 36 : 26,
                      height: index == 0 ? 44 : 45,
                    ),
                  ),
                  CustomButton(title: "Try", isHasMultipleWidget: false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 75,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                      color: bSecondaryLightColor,
                    ),
                    child: Center(
                      child: Text(
                        "OPEN",
                        style: TextStyle(
                          color: bSecondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        isHaSBorder: false),
  );
}

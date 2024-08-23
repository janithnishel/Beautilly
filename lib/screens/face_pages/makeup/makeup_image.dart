import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/share_widget/face_page.dart';
import 'package:flutter/material.dart';

class MakeupImage extends StatelessWidget {
  const MakeupImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/targetAudience.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomBox(
                          isHaSBorder: false,
                          borderRadius: 70,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: Image.asset(
                                  "assets/images/makeupImage.png",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomBox(
                            width: MediaQuery.of(context).size.width,
                            borderRadius: 20,
                            widget: Padding(
                              padding: const EdgeInsets.only(
                                  top: 40, left: 20, right: 20, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Skin Tone",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(
                                        0xff111111,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 75, vertical: 10),
                                    child: Text(
                                      "Fare skin",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: bGrey),
                                    ),
                                  ),
                                  Text(
                                    "Skin Tone",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(
                                        0xff111111,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 75, top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Oily skin",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: bGrey),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          size: 20,
                                          color: bPrimaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isHaSBorder: false)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        facePage(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

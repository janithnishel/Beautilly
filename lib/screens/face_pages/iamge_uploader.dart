import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/share_widget/face_page.dart';
import 'package:flutter/material.dart';

class ImageUpload extends StatelessWidget {
  const ImageUpload({super.key});

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
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          widget: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 65),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Please upload your face image here",
                                  style: TextStyle(
                                    color: bPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/uploadIcon.png",
                                  fit: BoxFit.cover,
                                  width: 55,
                                  height: 65,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        facePage(context),
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

import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/share_widget/face_page.dart';
import 'package:flutter/material.dart';

class FaceTreatImageUpload extends StatefulWidget {
  const FaceTreatImageUpload({super.key});

  @override
  State<FaceTreatImageUpload> createState() => _FaceTreatImageUploadState();
}

class _FaceTreatImageUploadState extends State<FaceTreatImageUpload> {
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
                          height: 400,
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: Image.asset(
                                  "assets/images/faceImage.png",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                ),
                              ),
                            ],
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Processing...",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(
                                  0xff111111,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

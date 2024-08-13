import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class ShopDetails extends StatelessWidget {
  const ShopDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: bPrimaryColor,
          size: 20,
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                bPrimaryColor.withOpacity(0.3),
                bPrimaryColor.withOpacity(0.126),
                bPrimaryColor.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      "assets/images/Monocromatic.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      "assets/images/Accent.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              SizedBox(
                    height: 75,
                  ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      "assets/images/Artwork.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width:40,
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      "assets/images/MR.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
                
              ),
              SizedBox(
                    height:100,
                  ),
              CustomButton(
                  title: "Similar prefer groups", isHasMultipleWidget: false),
                  SizedBox(
                    height:40,
                  ),
              CustomButton(
                title: "Build Your Ideal Salon Destination",
                isHasMultipleWidget: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}

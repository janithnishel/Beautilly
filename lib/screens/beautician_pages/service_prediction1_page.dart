import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class ServicePrediction extends StatefulWidget {
  const ServicePrediction({super.key});

  @override
  State<ServicePrediction> createState() => _ServicePredictionState();
}

class _ServicePredictionState extends State<ServicePrediction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bWhite,
        titleSpacing: -15,
        elevation: 1,
        title: const Text(
          "Service Prediction Results",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: bBlackColor,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: bBlackColor,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    "Top 3 Recommended Beauticians",
                    softWrap: true,
                    style: TextStyle(
                        color: bBlackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                CustomButton(title: "view All", isHasMultipleWidget: true,widget:Icon(Icons.arrow_back_ios) ,)
              ],
            )
          ],
        ),
      ),
    );
  }
}

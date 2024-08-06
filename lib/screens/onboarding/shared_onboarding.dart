import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class SharedScreen extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final double? fontsize;
  final double? bottomPadding;
  const SharedScreen({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    this.fontsize,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            image,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  bBlackColor.withOpacity(0.001),
                  bBlackColor.withOpacity(0.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding ?? 220),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: fontsize ?? 24,
                      fontWeight: FontWeight.w500,
                      color: bWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: bWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

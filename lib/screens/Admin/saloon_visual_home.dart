import 'package:beautilly/screens/page_with_bottom_navigation.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class SaloonVisualHome extends StatelessWidget {
  const SaloonVisualHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/salloonVisual.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "\"Engage with Us to Co-Create \nPerfect Salon\"",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(25.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageWithBottomNavigation(),
                  ),
                );
              },
              child: CustomButton(
                title: "NEXT",
                isHasMultipleWidget: false,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

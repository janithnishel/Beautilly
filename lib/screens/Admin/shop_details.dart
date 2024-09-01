import 'package:beautilly/screens/Admin/SimilarGroup.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';


class ShopDetails extends StatelessWidget {
  final Map<String, dynamic> visuals;

  const ShopDetails({super.key, required this.visuals});

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
                    child: Image.network(
                      visuals["Color"] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      visuals["Decor"] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 75),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      visuals["Lighting"] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      visuals["Furniture"] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SimilarGroup(),
                    ),
                  );
                },
                child: const CustomButton(
                  title: "Similar prefer groups",
                  isHasMultipleWidget: false,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40),
              const CustomButton(
                title: "Build Your Ideal Salon Destination",
                isHasMultipleWidget: false,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

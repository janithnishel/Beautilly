import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/utils/global_state.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:beautilly/api/apiservice.dart';

class SimilarGroup extends StatefulWidget {
  const SimilarGroup({super.key});

  @override
  _SimilarGroupState createState() => _SimilarGroupState();
}

class _SimilarGroupState extends State<SimilarGroup> {
  Map<String, String>? visuals;

  @override
  void initState() {
    super.initState();
    _fetchVisuals();
  }

  Future<void> _fetchVisuals() async {
    try {
      Map<String, dynamic> fetchedVisuals =
          await ApiService.fetchVisualsByCluster(
        GlobalState.selectedGender,
        GlobalState.selectedAgeGroup,
        GlobalState.selectedIncome,
      );

      setState(() {
        visuals = {
          "Color": fetchedVisuals['Color'],
          "Decor": fetchedVisuals['Decor'],
          "Lighting": fetchedVisuals['Lighting'],
          "Furniture": fetchedVisuals['Furniture'],
          "WashingStation": fetchedVisuals['WashingStation'],
          "StylingStation": fetchedVisuals['StylingStation'],
          "WaitingArea": fetchedVisuals['WaitingArea'],
        };
      });
    } catch (e) {
      // Handle the error, e.g., show a message
      print('Failed to fetch visuals: $e');
    }
  }

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
      body: visuals == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching data
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      title: "Demographics",
                      isHasMultipleWidget: false,
                    ),
                    SizedBox(height: 20),

                    // Demographics Section
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/images/image_22.png', // Replace with age range icon
                            height: 50,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          GlobalState
                              .selectedAgeGroup, // Display the selected age group
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/images/image_23.png', // Replace with gender icon
                            height: 50,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          GlobalState
                              .selectedGender, // Display the selected gender
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/images/image_24.png', // Replace with income level icon
                            height: 50,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          GlobalState
                              .selectedIncome, // Display the selected income level
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    CustomButton(
                      title: "Preferences",
                      isHasMultipleWidget: false,
                    ),
                    SizedBox(height: 20),

                    // Preferences Section
                    Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            visuals![
                                'Color']!, // Display the color image from the URL
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Image.network(
                            visuals![
                                'Decor']!, // Display the decor image from the URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            visuals![
                                'Lighting']!, // Display the lighting image from the URL
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Image.network(
                            visuals![
                                'Furniture']!, // Display the furniture image from the URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            visuals![
                                'WashingStation']!, // Display the washing station image from the URL
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Image.network(
                            visuals![
                                'StylingStation']!, // Display the styling station image from the URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            visuals![
                                'WaitingArea']!, // Display the waiting area image from the URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
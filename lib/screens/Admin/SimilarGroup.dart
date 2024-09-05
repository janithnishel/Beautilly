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
  List<Map<String, dynamic>> visualsList = [];
  Set<String> printedDemographics = {}; // To keep track of unique demographic combinations

  @override
  void initState() {
    super.initState();
    _fetchVisuals();
  }

  Future<void> _fetchVisuals() async {
    try {
      List<Map<String, dynamic>> fetchedVisuals = List<Map<String, dynamic>>.from(
        await ApiService.fetchVisualsByCluster(
          GlobalState.selectedGender,
          GlobalState.selectedAgeGroup,
          GlobalState.selectedIncome,
        )
      );

      setState(() {
        visualsList = fetchedVisuals;
      });
    } catch (e) {
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
      body: visualsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomButton(
                      title: "Demographics",
                      isHasMultipleWidget: false,
                    ),
                    const SizedBox(height: 20),
                    ...visualsList.where((visual) {
                      String demographicKey = '${visual['age']}_${visual['gender']}_${visual['income_level']}';
                      return printedDemographics.add(demographicKey); // Ensures unique combination is printed only once
                    }).map((visual) => Column(
                      children: [
                        _buildDemographicRow('assets/images/image_22.png', visual['age']!),
                        const SizedBox(height: 20),
                        _buildDemographicRow('assets/images/image_23.png', visual['gender']!),
                        const SizedBox(height: 20),
                        _buildDemographicRow('assets/images/image_24.png', visual['income_level']!),
                        const SizedBox(height: 20),
                      ],
                    )),
                    const CustomButton(
                      title: "Preferences",
                      isHasMultipleWidget: false,
                    ),
                    const SizedBox(height: 20),
                    // Display preferences for each visual
                    ...visualsList.map((visual) => Column(
                      children: [
                        _buildPreferenceRow(visual['Color']!),
                        const SizedBox(height: 20),
                        _buildPreferenceRow(visual['Decor']!),
                        const SizedBox(height: 20),
                        _buildPreferenceRow(visual['Lighting']!),
                        const SizedBox(height: 20),
                        _buildPreferenceRow(visual['Furniture']!),
                        const SizedBox(height: 20),
                        _buildPreferenceRow(visual['WashingStation']!),
                        const SizedBox(height: 20),
                        _buildPreferenceRow(visual['StylingStation']!),
                        const SizedBox(height: 20),
                        _buildPreferenceRow(visual['WaitingArea']!),
                        const SizedBox(height: 20),
                      ],
                    )),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDemographicRow(String assetPath, String text) {
    return Row(
      children: [
        Expanded(
          child: Image.asset(assetPath, height: 50),
        ),
        const SizedBox(width: 20),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildPreferenceRow(String imageUrl) {
    return Row(
      children: [
        Expanded(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

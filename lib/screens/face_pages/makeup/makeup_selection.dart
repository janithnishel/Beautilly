import 'package:flutter/material.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/models/recomended_color_model.dart';

class MakeupSelection extends StatefulWidget {
  final String skinTone;
  final List<Map<String, String>> makeupSuggestions;

  const MakeupSelection({
    Key? key,
    required this.skinTone,
    required this.makeupSuggestions,
  }) : super(key: key);

  @override
  State<MakeupSelection> createState() => _MakeupSelectionState();
}

class _MakeupSelectionState extends State<MakeupSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bWhite,
        elevation: 0.5,
        leading: const Icon(
          Icons.arrow_back_ios_sharp,
          size: 20,
          color: bPrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Skin Tone: ${widget.skinTone}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: bPrimaryColor,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Makeup Recommendations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: bPrimaryColor,
                ),
              ),
              SizedBox(height: 20),
              ...widget.makeupSuggestions.map((suggestion) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMakeupSuggestionRow(
                      'Foundation',
                      suggestion['Foundation']!,
                    ),
                    _buildMakeupSuggestionRow(
                      'Concealer',
                      suggestion['Concealer']!,
                    ),
                    _buildMakeupSuggestionRow(
                      'Blush',
                      suggestion['Blush']!,
                    ),
                    _buildMakeupSuggestionRow(
                      'Lipstick',
                      suggestion['Lipstick']!,
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMakeupSuggestionRow(String label, String colorName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label: $colorName',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: bDarkGrey,
          ),
        ),
        _buildColorSample(colorName),
      ],
    );
  }

  // Assuming colorData contains the map of color names to actual colors
  Widget _buildColorSample(String colorName) {
    // You need to have a map or method to get color by its name
    final color = _getColorByName(colorName);

    return Container(
      width: 50,
      height: 20,
      color: color,
    );
  }

  // This method should return the Color object based on the color name
  Color _getColorByName(String colorName) {
    // This should match with the colors you want to show
    switch (colorName.toLowerCase()) {
      case 'mocha':
        return Color(0XFFA52A2A);
      case 'deep chestnut':
        return Color(0XFFCD5C5C);
      // Add other colors here
      default:
        return bPrimaryColor; // Fallback color
    }
  }
}

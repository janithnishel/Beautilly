import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';

class FaceTreatmentImage extends StatefulWidget {
  const FaceTreatmentImage({super.key});

  @override
  _FaceTreatmentImageState createState() => _FaceTreatmentImageState();
}

class _FaceTreatmentImageState extends State<FaceTreatmentImage> {
  String message = 'No issues detected'; // Default message for normal skin
  double affectedPercentage = 0.0;
  String treatmentIssue = 'Normal Skin'; // Default issue for normal skin
  String treatmentName = 'No treatment necessary'; // Default treatment name for normal skin
  String treatmentFrequency = 'None'; // Default frequency for normal skin
  int treatmentDurationWeeks = 0; // Default duration for normal skin
  String treatmentSeverity = 'None'; // Default severity for normal skin
  bool isLoading = false;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Treatment Analysis"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              imageSelectionWidget(),
              const SizedBox(height: 20),
              displayResultsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageSelectionWidget() {
    return GestureDetector(
      onTap: _pickImage,
      child: CustomBox(
        isHaSBorder: false,
        borderRadius: 70,
        width: MediaQuery.of(context).size.width,
        height: 275,
        widget: Stack(
          fit: StackFit.expand,
          children: [
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 275,
                  )
                : Image.asset(
                    "assets/images/faceImage.png",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 275,
                  ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget displayResultsWidget() {
    return CustomBox(
      width: MediaQuery.of(context).size.width,
      borderRadius: 20,
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildResultDetails(),
        ),
      ),
      isHaSBorder: false,
    );
  }

  List<Widget> buildResultDetails() {
    return [
      buildDetail("Message", message),
      buildDetail("Affected Percentage", "$affectedPercentage%"),
      buildDetail("Issue", treatmentIssue),
      buildDetail("Treatment Name", treatmentName),
      buildDetail("Frequency", treatmentFrequency),
      buildDetail("Duration", "$treatmentDurationWeeks weeks"),
      buildDetail("Severity", treatmentSeverity),
    ];
  }

  Widget buildDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: bGrey,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        isLoading = true;
      });
      await _uploadAndAnalyzeImage(_selectedImage!);
    }
  }

  Future<void> _uploadAndAnalyzeImage(File image) async {
    try {
      var response = await ApiService.uploadImageForAcneDetection(image);

      setState(() {
        updateUIWithResponse(response);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        message = 'Error: ${e.toString()}';
        isLoading = false;
      });
      print('Upload error: $e');
    }
  }

  void updateUIWithResponse(Map<String, dynamic> response) {
    setState(() {
      message = response['message'] ?? 'No issues detected';
      affectedPercentage = response.containsKey('affected_percentage') ? response['affected_percentage'].toDouble() : 0.0;
      
      if (response.containsKey('treatment') && response['treatment'] != null) {
        treatmentIssue = response['treatment']['Issue'] ?? 'Normal Skin';
        treatmentName = response['treatment']['Treatment_Name'] ?? 'No treatment necessary';
        treatmentFrequency = response['treatment']['Frequency'] ?? 'None';
        treatmentDurationWeeks = response['treatment']['Duration_Weeks'] ?? 0;
        treatmentSeverity = response['treatment']['Severity'] ?? 'None';
      } else {
        // Default to normal skin if treatment details are missing
        treatmentIssue = 'Normal Skin';
        treatmentName = 'No treatment necessary';
        treatmentFrequency = 'None';
        treatmentDurationWeeks = 0;
        treatmentSeverity = 'None';
      }
    });
  }
}

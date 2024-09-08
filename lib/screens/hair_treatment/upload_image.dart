import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:beautilly/api/apiservice.dart';
import 'hair_type_prediction.dart';  // Import the next page

class UploadIamge extends StatefulWidget {
  const UploadIamge({super.key});

  @override
  State<UploadIamge> createState() => _UploadIamgeState();
}

class _UploadIamgeState extends State<UploadIamge> {
  File? _selectedImage;
  String? _hairType;
  bool _isLoading = false;
  List<Map<String, dynamic>> _recommendations = [];
  String _selectedPriceRange = "Luxury"; // Default value for dropdown

  // Function to pick image from the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Function to upload image and get hair prediction
  Future<void> _uploadAndPredictHairType() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ApiService.uploadHairImageForProcessing(_selectedImage!);

      setState(() {
        _hairType = result['hairType'];
        _recommendations = List<Map<String, dynamic>>.from(result['recommendations']);
      });
    } catch (error) {
      print('Error uploading image: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to show image source options (camera or gallery)
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/hairBackground.png",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Column(
                        children: [
                          CustomBox(
                            widget: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios_sharp,
                                    color: bPrimaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.87,
                                    child: const Center(
                                      child: Text(
                                        "Hair Type Prediction",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: bBlackColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isHaSBorder: false,
                            borderRadius: 0,
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            color: bWhite.withOpacity(0.9),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (_selectedImage != null)
                                  CustomBox(
                                    widget: ClipRRect(
                                      borderRadius: BorderRadius.circular(75),
                                      child: Image.file(
                                        _selectedImage!,
                                        fit: BoxFit.cover,
                                        width: 230,
                                        height: 290,
                                      ),
                                    ),
                                    isHaSBorder: false,
                                    width: 230,
                                    height: 290,
                                    borderRadius: 75,
                                  ),
                                const SizedBox(height: 15),
                                GestureDetector(
                                  onTap: _selectedImage == null
                                      ? _showImageSourceOptions
                                      : _uploadAndPredictHairType,
                                  child: CustomButton(
                                    title: _selectedImage == null
                                        ? "Upload Image"
                                        : "Process Image",
                                    isHasMultipleWidget: false,
                                    color: bWhite.withOpacity(0.9),
                                    textColor: bBlackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                if (_isLoading)
                                  const CircularProgressIndicator(),
                                if (_hairType != null && !_isLoading)
                                  CustomBox(
                                    widget: Column(
                                      children: [
                                        const Text(
                                          "YOUR HAIR TYPE IS:",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: bBlackColor,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Center(
                                          child: Text(
                                            _hairType!,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              color: bPrimaryColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        _buildPriceRangeDropdown(),
                                      ],
                                    ),
                                    isHaSBorder: false,
                                    borderRadius: 20,
                                    width: MediaQuery.of(context).size.width,
                                    color: bWhite.withOpacity(0.9),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRangeDropdown() {
    return DropdownButton<String>(
      value: _selectedPriceRange,
      items: const [
        DropdownMenuItem(value: "Luxury", child: Text("Luxury")),
        DropdownMenuItem(value: "Affordable", child: Text("Affordable")),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedPriceRange = newValue!;
        });
        // Navigate to HairTypePrediction with selected price range
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HairTypePrediction(
              selectedPriceRange: _selectedPriceRange,
              recommendations: _filterRecommendations(),
            ),
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterRecommendations() {
    return _recommendations.where((recommendation) {
      return recommendation['Price Range'] == _selectedPriceRange;
    }).toList();
  }
}

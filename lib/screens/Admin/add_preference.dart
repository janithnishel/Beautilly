import 'dart:io';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:beautilly/widget/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPreference extends StatefulWidget {
  const AddPreference({super.key});

  @override
  State<AddPreference> createState() => _AddPreferenceState();
}

int isSelected = 99;

class _AddPreferenceState extends State<AddPreference> {
  File? _selectedColorSchemeImage;
  File? _selectedDecorStyleImage;
  File? _selectedLightingImage;
  File? _selectedFurnitureImage;
  File? _selectedStylingStationImage;
  File? _selectedWashingStationImage;
  File? _selectedWaitingAreaImage;

  Future<void> _pickImage(Function(File) onImageSelected) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        onImageSelected(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/preferencePage.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/backArrow.png",
                          fit: BoxFit.cover,
                          color: bPrimaryColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Enter Your Preferences",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff111111),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      title: "Age",
                      isHasMultipleWidget: true,
                      rightSideImage: CustomDropdownButton(
                        dropdownItems: ["18-24", "25-34", "35-44", "45-54"],
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Gender",
                      isHasMultipleWidget: true,
                      rightSideImage: CustomDropdownButton(
                        dropdownItems: ["Male", "Female"],
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Income Level",
                      isHasMultipleWidget: true,
                      rightSideImage: CustomDropdownButton(
                        dropdownItems: ["Low", "Middle", "High"],
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Colour Scheme",
                      isHasMultipleWidget: true,
                      rightSideImage: GestureDetector(
                        onTap: () => _pickImage((file) => _selectedColorSchemeImage = file),
                        child: _selectedColorSchemeImage == null
                            ? Image.asset(
                                "assets/images/uploadImage.png",
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              )
                            : Image.file(
                                _selectedColorSchemeImage!,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Decor Style",
                      isHasMultipleWidget: true,
                      rightSideImage: GestureDetector(
                        onTap: () => _pickImage((file) => _selectedDecorStyleImage = file),
                        child: _selectedDecorStyleImage == null
                            ? Image.asset(
                                "assets/images/uploadImage.png",
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              )
                            : Image.file(
                                _selectedDecorStyleImage!,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Lighting",
                      isHasMultipleWidget: true,
                      rightSideImage: GestureDetector(
                        onTap: () => _pickImage((file) => _selectedLightingImage = file),
                        child: _selectedLightingImage == null
                            ? Image.asset(
                                "assets/images/uploadImage.png",
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              )
                            : Image.file(
                                _selectedLightingImage!,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Furniture",
                      isHasMultipleWidget: true,
                      rightSideImage: GestureDetector(
                        onTap: () => _pickImage((file) => _selectedFurnitureImage = file),
                        child: _selectedFurnitureImage == null
                            ? Image.asset(
                                "assets/images/uploadImage.png",
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              )
                            : Image.file(
                                _selectedFurnitureImage!,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Styling Station",
                      isHasMultipleWidget: true,
                      rightSideImage: GestureDetector(
                        onTap: () => _pickImage((file) => _selectedStylingStationImage = file),
                        child: _selectedStylingStationImage == null
                            ? Image.asset(
                                "assets/images/uploadImage.png",
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              )
                            : Image.file(
                                _selectedStylingStationImage!,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Washing Station",
                      isHasMultipleWidget: true,
                      rightSideImage: GestureDetector(
                        onTap: () => _pickImage((file) => _selectedWashingStationImage = file),
                        child: _selectedWashingStationImage == null
                            ? Image.asset(
                                "assets/images/uploadImage.png",
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              )
                            : Image.file(
                                _selectedWashingStationImage!,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      title: "Waiting Area",
                      isHasMultipleWidget: true,
                      rightSideImage: GestureDetector(
                        onTap: () => _pickImage((file) => _selectedWaitingAreaImage = file),
                        child: _selectedWaitingAreaImage == null
                            ? Image.asset(
                                "assets/images/uploadImage.png",
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              )
                            : Image.file(
                                _selectedWaitingAreaImage!,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                      ),
                      color: bWhite,
                      fontWeight: FontWeight.w600,
                      textColor: bBlackColor,
                      borderColor: bPrimaryColor,
                      isCenter: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = 0;
                            });
                          },
                          child: CustomButton(
                            title: "Cancel",
                            isHasMultipleWidget: false,
                            width: 150,
                            fontWeight: FontWeight.w600,
                            color: isSelected == 0 ? bPrimaryColor : bWhite,
                            textColor: isSelected == 0 ? bWhite : bBlackColor,
                            borderColor: isSelected == 0 ? null : bPrimaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = 1;
                            });
                            // Handle submit logic here.
                          },
                          child: CustomButton(
                            title: "Submit",
                            isHasMultipleWidget: false,
                            width: 150,
                            fontWeight: FontWeight.w600,
                            color: isSelected == 1 ? bPrimaryColor : bWhite,
                            textColor: isSelected == 1 ? bWhite : bBlackColor,
                            borderColor: isSelected == 1 ? null : bPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

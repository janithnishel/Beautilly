import 'dart:io';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:beautilly/widget/custom_dropdown_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:beautilly/api/apiservice.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  String _selectedAge = '18-24'; // Default age
  String _selectedGender = 'Male'; // Default gender
  String _selectedIncomeLevel = 'Low'; // Default income level

  bool isSubmitting = false; // State for submission

  Future<void> _pickImage(Function(File) onImageSelected) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        onImageSelected(File(pickedFile.path));
      });
    }
  }

  Future<String> _uploadImageToFirebase(File imageFile, String path) async {
    try {
      final storageReference = FirebaseStorage.instance.ref().child(path);
      final uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() {});
      return await storageReference.getDownloadURL();
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }
Future<void> _submitPreferences() async {
  setState(() {
    isSubmitting = true;
  });

  try {
    final customerId = 1; // Replace with actual customer ID

    // Fetch the current customer details
    final currentCustomerDetails = await ApiService.getCustomer(customerId);

    // Update the customer details with the selected dropdown values
    Map<String, dynamic> customerDetails = {
      "Customer_ID": customerId,
      "Name": currentCustomerDetails['Name'], // Keep existing Name
      "Gender": _selectedGender.isNotEmpty ? _selectedGender : currentCustomerDetails['Gender'],
      "Age": _selectedAge.isNotEmpty ? _selectedAge : currentCustomerDetails['Age'],
      "IncomeLevel": _selectedIncomeLevel.isNotEmpty ? _selectedIncomeLevel : currentCustomerDetails['IncomeLevel'],
      "Email": currentCustomerDetails['Email'], // Keep existing Email
      "Password": currentCustomerDetails['Password'], // Keep existing Password
    };


    // Log the request payload to inspect it before sending
    print("Sending customer details: $customerDetails");

    // API call to update customer preferences
    final updateResponse = await ApiService.updateCustomer(customerDetails);

    // Check the response status code
    if (updateResponse.statusCode == 200) {
      print("Customer preferences updated successfully.");

      // Proceed with uploading images only after successful update
      String colorUrl = _selectedColorSchemeImage != null
          ? await _uploadImageToFirebase(_selectedColorSchemeImage!, "preferences/color_scheme")
          : '';

      String decorUrl = _selectedDecorStyleImage != null
          ? await _uploadImageToFirebase(_selectedDecorStyleImage!, "preferences/decor_style")
          : '';

      String lightingUrl = _selectedLightingImage != null
          ? await _uploadImageToFirebase(_selectedLightingImage!, "preferences/lighting")
          : '';

      String furnitureUrl = _selectedFurnitureImage != null
          ? await _uploadImageToFirebase(_selectedFurnitureImage!, "preferences/furniture")
          : '';

      String washingStationUrl = _selectedWashingStationImage != null
          ? await _uploadImageToFirebase(_selectedWashingStationImage!, "preferences/washing_station")
          : '';

      String stylingStationUrl = _selectedStylingStationImage != null
          ? await _uploadImageToFirebase(_selectedStylingStationImage!, "preferences/styling_station")
          : '';

      String waitingAreaUrl = _selectedWaitingAreaImage != null
          ? await _uploadImageToFirebase(_selectedWaitingAreaImage!, "preferences/waiting_area")
          : '';

      // Construct the request body for visual preferences
      Map<String, dynamic> requestBody = {
        "Color": colorUrl,
        "Decor": decorUrl,
        "Lighting": lightingUrl,
        "Furniture": furnitureUrl,
        "WashingStation": washingStationUrl,
        "StylingStation": stylingStationUrl,
        "WaitingArea": waitingAreaUrl,
        "CustomerID": customerId, // Replace with actual customer ID
      };

      // Log the request body for visual preferences
      print("Sending visual preferences: $requestBody");

      // API call to submit visual preferences
      final response = await ApiService.submitVisualPreferences(requestBody);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Preferences and photos updated successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        print("Visual preferences updated successfully.");
      } else {
        Fluttertoast.showToast(
          msg: "Failed to upload photos",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        print("Failed to upload photos. Status code: ${response.statusCode}");
      }
    } else {
      Fluttertoast.showToast(
        msg: "Failed to update preferences",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      print("Failed to update preferences. Status code: ${updateResponse.statusCode}");
    }
  } catch (e) {
    print("Error submitting preferences: $e");
    Fluttertoast.showToast(
      msg: "Error submitting preferences",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  } finally {
    setState(() {
      isSubmitting = false;
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
                        value: _selectedAge,
                        onChanged: (val) => setState(() => _selectedAge = val),
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
                        value: _selectedGender,
                        onChanged: (val) => setState(() => _selectedGender = val),
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
                        value: _selectedIncomeLevel,
                        onChanged: (val) => setState(() => _selectedIncomeLevel = val),
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
                    isSubmitting
                        ? CircularProgressIndicator()
                        : Row(
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
                                  _submitPreferences();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

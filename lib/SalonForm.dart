import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:beautilly/api/apiservice.dart';

class SalonForm extends StatefulWidget {
  @override
  _SalonFormState createState() => _SalonFormState();
}

class _SalonFormState extends State<SalonForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _ratingScoreController = TextEditingController();
  final TextEditingController _characteristicsController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _salonIdController = TextEditingController();

  File? _selectedImageFile;
  String? _selectedSalonName;
  List<Map<String, dynamic>> _salons = [];
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchSalons();
  }

  // Fetch all salons from the API
  Future<void> _fetchSalons() async {
    try {
      final salons = await ApiService.getAllSalons();
      setState(() {
        _salons = salons;
      });
    } catch (e) {
      print('Error fetching salons: $e');
    }
  }

  // Upload image to Firebase
  Future<String> _uploadImageToFirebase(File imageFile) async {
    try {
      final storageReference = FirebaseStorage.instance.ref().child('beautician_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() {});
      return await storageReference.getDownloadURL();
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }

  // Handle image picker
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
      });
    }
  }

  // Submit form with beautician details
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmitting = true;
      });

      try {
        // Upload image and get URL
        String imageUrl = _selectedImageFile != null ? await _uploadImageToFirebase(_selectedImageFile!) : _imageController.text;

        // Retrieve form values
        final String name = _nameController.text;
        final int age = int.parse(_ageController.text);
        final String gender = _genderController.text;
        final String position = _positionController.text;
        final double ratingScore = double.parse(_ratingScoreController.text);
        final String characteristics = _characteristicsController.text;
        final int salonId = int.parse(_salonIdController.text);

        // Create the JSON-like map
        final Map<String, dynamic> formData = {
          "Name": name,
          "Age": age,
          "Gender": gender,
          "Position": position,
          "Rating_Score": ratingScore,
          "Characteristics": characteristics,
          "Image": imageUrl,
          "Salon_ID": salonId,
        };

        // Post beautician details
        final response = await ApiService.postBeautician(formData);
        print('Beautician posted successfully: ${response.body}');
      } catch (e) {
        print('Error submitting form: $e');
      } finally {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  // Update form fields when salon is selected
  void _updateFormWithSalonData(Map<String, dynamic> salonData) {
    _salonIdController.text = salonData['Salon_ID'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salon Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Salon'),
                value: _selectedSalonName,
                items: _salons.map((salon) {
                  return DropdownMenuItem<String>(
                    value: salon['Name'],
                    child: Text(salon['Name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSalonName = value;
                    final selectedSalon = _salons.firstWhere((salon) => salon['Name'] == value);
                    _updateFormWithSalonData(selectedSalon);
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a salon';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _positionController,
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter position';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ratingScoreController,
                decoration: InputDecoration(labelText: 'Rating Score'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rating score';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _characteristicsController,
                decoration: InputDecoration(labelText: 'Characteristics'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter characteristics';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salonIdController,
                decoration: InputDecoration(labelText: 'Salon ID'),
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: _selectedImageFile == null
                    ? Column(
                        children: [
                          Image.asset(
                            'assets/images/uploadImage.png',  // Add this icon for image upload
                            height: 100,
                            width: 100,
                          ),
                          Text(
                            'Upload Image',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    : Image.file(
                        _selectedImageFile!,
                        height: 150,
                        width: 150,
                      ),
              ),
              SizedBox(height: 20),
              isSubmitting
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _positionController.dispose();
    _ratingScoreController.dispose();
    _characteristicsController.dispose();
    _imageController.dispose();
    _salonIdController.dispose();
    super.dispose();
  }
}

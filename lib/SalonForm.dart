import 'package:flutter/material.dart';

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
  final TextEditingController _characteristicsController =
      TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _salonIdController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Retrieve form values
      final String name = _nameController.text;
      final int age = int.parse(_ageController.text);
      final String gender = _genderController.text;
      final String position = _positionController.text;
      final double ratingScore = double.parse(_ratingScoreController.text);
      final String characteristics = _characteristicsController.text;
      final String image = _imageController.text;
      final int salonId = int.parse(_salonIdController.text);

      // Create the JSON-like map
      final Map<String, dynamic> formData = {
        "Name": name,
        "Age": age,
        "Gender": gender,
        "Position": position,
        "Rating_Score": ratingScore,
        "Characteristics": characteristics,
        "Image": image,
        "Salon_ID": salonId,
      };

      print('Form Data: $formData');
    }
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
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salonIdController,
                decoration: InputDecoration(labelText: 'Salon ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter salon ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
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

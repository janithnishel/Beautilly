import 'package:beautilly/screens/face_pages/makeup/FacePositionCamera.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'makeup_selection.dart'; 
import 'package:beautilly/api/apiservice.dart';
import 'package:flutter/foundation.dart'; // For compute function
import 'package:image/image.dart' as img;

class MakeupImage extends StatefulWidget {
  const MakeupImage({super.key});

  @override
  _MakeupImageState createState() => _MakeupImageState();
}

class _MakeupImageState extends State<MakeupImage> {
  bool _isLoading = false;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            size: 20,
            color: Color(0xff111111),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "assets/images/targetAudience.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => _showImageSourceActionSheet(context),
                              child: CustomBox(
                                isHaSBorder: false,
                                borderRadius: 70,
                                width: MediaQuery.of(context).size.width,
                                height: 450,
                                widget: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: _selectedImage == null
                                      ? Image.asset(
                                          "assets/images/face.jpg",
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context).size.width,
                                          height: 450,
                                        )
                                      : Image.file(
                                          _selectedImage!,
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context).size.width,
                                          height: 450,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomBox(
                              width: MediaQuery.of(context).size.width,
                              borderRadius: 20,
                              widget: const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "Please position your face correctly",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff111111),
                                  ),
                                ),
                              ),
                              isHaSBorder: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Open Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _openCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final croppedFile = await _cropImage(pickedFile.path);
      if (croppedFile != null) {
        setState(() {
          _selectedImage = croppedFile;
        });
        await _sendImageToBackend(croppedFile);
      }
    }
  }

  Future<void> _openCamera() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FacePositionCamera(),
      ),
    );
  }

  Future<File?> _cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );

    if (croppedFile != null) {
      return await _convertToJpg(File(croppedFile.path));
    }
    return null;
  }

  Future<File> _convertToJpg(File imageFile) async {
    final image = img.decodeImage(imageFile.readAsBytesSync());
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    final directory = await getApplicationDocumentsDirectory();
    final jpgFilePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final jpgFile = File(jpgFilePath)
      ..writeAsBytesSync(img.encodeJpg(image, quality: 100)); // Save as JPG

    return jpgFile;
  }

  Future<void> _sendImageToBackend(File imageFile) async {
    setState(() {
      _isLoading = true;
    });

    try {
      print('Uploading image: ${imageFile.path}');
      print('File size: ${imageFile.lengthSync()} bytes');

      final response = await compute(uploadImage, imageFile);

      if (response.isNotEmpty) {
        if (!mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MakeupSelection(
              skinTone: response['skin_tone'],
              makeupSuggestions: response['makeup_suggestions'],
              imagePath: imageFile.path,  // Pass the image file path to MakeupSelection
            ),
          ),
        );
      } else {
        throw Exception('Failed to upload image for skin color detection');
      }
    } catch (e) {
      print('Error uploading image: $e');
      if (mounted) {
        _showErrorDialog(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static Future<Map<String, dynamic>> uploadImage(File imageFile) async {
    try {
      return await ApiService.uploadSkinColorImage(imageFile);
    } catch (e) {
      print('Failed to upload image: $e');
      return {};
    }
  }
}

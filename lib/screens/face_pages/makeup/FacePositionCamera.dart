import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:beautilly/api/apiservice.dart';
import 'package:path_provider/path_provider.dart';
import 'makeup_selection.dart'; // Import MakeupSelection
import 'package:image/image.dart' as img;

class FacePositionCamera extends StatefulWidget {
  @override
  _FacePositionCameraState createState() => _FacePositionCameraState();
}

class _FacePositionCameraState extends State<FacePositionCamera> {
  CameraController? _controller;
  bool _isFacePositionedCorrectly = false; // Track if face is positioned correctly
  bool _isTakingPicture = false; // Track if a picture is being taken
  List<CameraDescription>? cameras;
  CameraDescription? selectedCamera;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    cameras = await availableCameras();
    selectedCamera = cameras?.first;

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    if (selectedCamera == null) return;

    _controller = CameraController(
      selectedCamera!,
      ResolutionPreset.high,
    );

    await _controller?.initialize();

    if (!mounted) return;

    setState(() {});
  }

  void _switchCamera() {
    if (cameras == null || cameras!.isEmpty) return;

    setState(() {
      selectedCamera = (selectedCamera == cameras?.first)
          ? cameras?.last
          : cameras?.first;
    });

    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // Method to handle face detection and positioning
  void _onFaceDetected(bool isPositionedCorrectly) {
    setState(() {
      _isFacePositionedCorrectly = isPositionedCorrectly;
    });
  }

  // Method to take a picture and crop it to the circle area
  Future<void> _takePicture() async {
    if (_isTakingPicture) return;

    setState(() {
      _isTakingPicture = true; // Show loading indicator
    });

    try {
      final image = await _controller?.takePicture();
      if (image != null) {
        final croppedImage = await _cropToCircle(File(image.path));
        final response = await ApiService.uploadSkinColorImage(croppedImage);

        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MakeupSelection(
                skinTone: response['skin_tone'],
                makeupSuggestions: response['makeup_suggestions'], imagePath: '',
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('Error taking picture: $e');
      if (mounted) {
        _showErrorDialog(context, 'Failed to upload image for skin color detection');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTakingPicture = false; // Hide loading indicator
        });
      }
    }
  }

  // Method to crop the image to the circle area
  Future<File> _cropToCircle(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/cropped_image.png';

    final originalImage = img.decodeImage(imageFile.readAsBytesSync());
    if (originalImage == null) {
      throw Exception('Failed to decode image.');
    }

    final size = originalImage.width < originalImage.height
        ? originalImage.width
        : originalImage.height;
    final centerX = originalImage.width ~/ 2;
    final centerY = originalImage.height ~/ 2;

    final circleImage = img.copyCrop(
      originalImage,
      centerX - size ~/ 2,
      centerY - size ~/ 2,
      size,
      size,
    );

    final croppedImage = img.copyResizeCropSquare(circleImage, 400); // Resize if needed
    final newImage = img.encodePng(croppedImage);

    final file = File(path);
    await file.writeAsBytes(newImage);

    return file;
  }

  void _showErrorDialog(BuildContext context, String message) {
    if (!mounted) return; // Ensure the widget is still mounted

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isFacePositionedCorrectly ? Colors.green : Colors.red,
                  width: 4,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: ElevatedButton(
              onPressed: _takePicture,
              child: _isTakingPicture
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text('Take Picture'),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.switch_camera),
              color: Colors.white,
              onPressed: _switchCamera,
            ),
          ),
        ],
      ),
    );
  }
}

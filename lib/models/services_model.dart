import 'package:flutter/material.dart';

class ServicesModel {
  final String imageUrl;
  final String title;
  final Widget destinationPage; // Make sure this is the correct parameter name

  ServicesModel({
    required this.imageUrl,
    required this.title,
    required this.destinationPage, // This should match what you are passing in the list
  });
}
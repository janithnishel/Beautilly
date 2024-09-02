import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? suffix;
  final String title;
  final TextEditingController controller;
  final TextInputType? inputType;

  CustomTextFormField({
    super.key,
    required this.suffix,
    required this.title,
    required this.controller,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        fillColor: bWhite,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: bPrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: bPrimaryColor),
        ),
        suffixIcon: suffix,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: const TextStyle(
              color: bBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

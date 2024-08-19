import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget suffix;
  final String title;

  CustomTextFormField({
    super.key,
    required this.suffix,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: bWhite,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
        prefixIcon: Text(
          title,
          style: const TextStyle(
            color: bBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

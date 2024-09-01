import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? enableBorderRadius;
  final double? foccusBorderRadius;
  final Color? fillColor;
  final bool isHasHintText;
  final bool isHasssuffixIcon;
  final bool isHasPrefixIcon;
  final Color? hintTextColor;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FontWeight? hintTextFw;
  final Color? enableBorderColor;
  final Color? foccusBorderColor;
  final double? horizontalPadding;

  const CustomTextField({
    super.key,
    this.enableBorderRadius,
    this.foccusBorderRadius,
    this.fillColor,
    required this.isHasHintText,
    required this.isHasssuffixIcon,
    required this.isHasPrefixIcon,
    this.hintTextColor,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintTextFw,
    this.enableBorderColor,
    this.foccusBorderColor,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: bPrimaryColor,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        isDense: true,
        hintText: isHasHintText ? hintText : null,
        hintStyle: TextStyle(
          color: hintTextColor ?? bLowLightGrey,
          fontSize: 14,
          fontWeight: hintTextFw,
        ),
        prefixIcon: isHasPrefixIcon ? prefixIcon : null,
        suffixIcon: isHasssuffixIcon ? suffixIcon : null,
        contentPadding: EdgeInsets.symmetric(
            vertical: 12, horizontal: horizontalPadding ?? 5),
        fillColor: fillColor ?? bLowLightGrey,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(foccusBorderRadius ?? 5),
          borderSide: BorderSide(
            color: enableBorderColor ?? Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(foccusBorderRadius ?? 5),
          borderSide: BorderSide(
            color: foccusBorderColor ?? Colors.transparent,
          ),
        ),
      ),
    );
  }
}

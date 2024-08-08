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
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        cursorColor: bPrimaryColor,
        style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          isDense: true,
          hintText: isHasHintText ? hintText : null,
          hintStyle: TextStyle(color: bLowLightGrey, fontSize: 14),
          prefixIcon: isHasPrefixIcon ? prefixIcon : null,
          suffixIcon: isHasssuffixIcon ? suffixIcon : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          fillColor: fillColor ?? bLowLightGrey,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(foccusBorderRadius ?? 5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(foccusBorderRadius ?? 5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

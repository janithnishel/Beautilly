import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? strokWidth;
  final double? fontSize;
  final double? radius;
  final Widget? widget;

  const CustomButton({
    super.key,
    required this.title,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.borderColor,
    this.strokWidth,
    this.fontSize,
    this.radius,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 54,
      decoration: BoxDecoration(
        color: color ?? bPrimaryColor,
        borderRadius: BorderRadius.circular(radius ?? 50),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: strokWidth ?? 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget ?? const Text(""),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
              color: textColor ?? bWhite,
              fontSize: fontSize ?? 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

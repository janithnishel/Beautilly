import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isHasMultipleWidget;

  final Widget? widget;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? strokWidth;
  final double? fontSize;
  final double? radius;
  final double? width;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final double? shadowBlurRadius;

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
    required this.isHasMultipleWidget,
    this.fontWeight,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius,
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
      child: isHasMultipleWidget
          ? Row(
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
                    fontWeight: fontWeight ?? FontWeight.w400,
                    shadows: [
                      Shadow(
                          blurRadius: shadowBlurRadius ?? 0,
                          color: shadowColor ?? Colors.transparent,
                          offset: shadowOffset ?? const Offset(0, 0)),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor ?? bWhite,
                  fontSize: fontSize ?? 16,
                  fontWeight: fontWeight ?? FontWeight.w400,
                ),
              ),
            ),
    );
  }
}

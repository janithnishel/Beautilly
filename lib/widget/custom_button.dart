import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isHasMultipleWidget;
  final bool? isCenter;
  final Color? color;
  final Color? shadowColor;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? strokWidth;
  final double? fontSize;
  final double? radius;
  final double? width;
  final double? shadowBlurRadius;
  final Widget? leftSideWidget;
  final String title;
  final Offset? shadowOffset;
  final Widget? rightSideImage;
  final FontWeight? fontWeight;

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
    this.leftSideWidget,
    required this.isHasMultipleWidget,
    this.fontWeight,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius,
    this.rightSideImage,
    this.isCenter,
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
          ? isCenter ?? true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    leftSideWidget ?? const Text(""),
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
                            offset: shadowOffset ?? const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    rightSideImage ?? Text("")
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                              offset: shadowOffset ?? const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      rightSideImage ??Text("")
                    ],
                  ),
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

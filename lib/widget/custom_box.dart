import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final Color? color;
  final Color? BorderColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? borderWidth;
  final Widget widget;
  final bool isHaSBorder;
  final double? blurRadius;
  final Offset? shadowOfset;
  final Color? shadowColor;

  const CustomBox({
    super.key,
    required this.widget,
    this.color,
    this.width,
    this.borderRadius,
    required this.isHaSBorder,
    this.BorderColor,
    this.borderWidth,
    this.height,
    this.blurRadius,
    this.shadowOfset,
   this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.6,
      height: height ?? null,
      decoration: BoxDecoration(
        color: color ?? bWhite,
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        boxShadow: [
          BoxShadow(
            blurRadius: blurRadius ?? 8,
            offset: shadowOfset ?? Offset(0, 4),
            color: shadowColor ?? bLowLightGrey,
          )
        ],
        border: Border.all(
          width: isHaSBorder ? borderWidth ?? 2 : 0,
          color:
              isHaSBorder ? BorderColor ?? bPrimaryColor : Colors.transparent,
        ),
      ),
      child: widget,
    );
  }
}

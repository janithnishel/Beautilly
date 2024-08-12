import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final Widget widget;
  const CustomBox({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: bWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: bPrimaryColor,
        ),
      ),
      child: widget,
    );
  }
}

import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBar(String title,BuildContext context) {
  return AppBar(
    backgroundColor: bWhite,
    titleSpacing: -15,
    elevation: 1,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: bBlackColor,
      ),
    ),
    leading: GestureDetector(
      onTap: () {
       Navigator.of(context).pop();
      },
      child: const Icon(
        Icons.arrow_back_ios,
        color: bBlackColor,
      ),
    ),
  );
}
// ignore_for_file: must_be_immutable

import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  List<String> dropdownItems = [];

  CustomDropdownButton({super.key, required this.dropdownItems});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  //This is the selected value in the dropdown
  String _selectedItem = "";

  // This is the list of items in the dropdown
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _selectedItem = widget.dropdownItems[0];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(20),
      icon: const Icon(Icons.arrow_drop_down_outlined),
      value: _selectedItem,
      menuMaxHeight: 150,
      style: const TextStyle(
        color: bBlackColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue!;
        });
      },
      items: widget.dropdownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Container(
              // decoration: BoxDecoration(border: ),
            
              width: 60,
            
              child: Text(
                value,
                style: TextStyle(color: bBlackColor),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

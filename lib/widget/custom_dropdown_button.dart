// ignore_for_file: must_be_immutable

import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  List<String> dropdownItems = [];
  String value;
  final void Function(String val) onChanged;

  CustomDropdownButton({
    super.key,
    required this.dropdownItems,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedItem with the passed value
    _selectedItem = widget.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
        if (newValue != null) {
          setState(() {
            _selectedItem = newValue;
          });
          // Call the onChanged function from the parent widget
          widget.onChanged(newValue);
        }
      },
      items: widget.dropdownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Container(
              width: 60,
              child: Text(
                value,
                style: const TextStyle(color: bBlackColor),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

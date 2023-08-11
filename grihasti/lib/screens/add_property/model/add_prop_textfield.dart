import 'package:flutter/material.dart';

class AddPropTextField extends StatelessWidget {
  final String hintText;
  final controller;
  final validator;
  final keyboardtype;
  final readOnly;
  final enabled;

  const AddPropTextField(
      {super.key,
      required this.hintText,
      this.controller,
      this.keyboardtype,
      this.readOnly,
      this.enabled,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keyboardtype,
        readOnly: false,
        enabled: enabled,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}

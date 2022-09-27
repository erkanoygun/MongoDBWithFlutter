import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.textInputType,
      this.initialValue})
      : super(key: key);
  final String labelText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        keyboardType: textInputType,
        controller: controller..text = initialValue ?? "",
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: labelText,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

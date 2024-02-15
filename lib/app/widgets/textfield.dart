import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController fieldController ;
  const CustomTextField({
    super.key,
    required this.hintText, required this.fieldController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        autocorrect: true,
        controller: fieldController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(
              maxHeight: 50,
            ),
            hintText: hintText.toString(),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))));
  }
}
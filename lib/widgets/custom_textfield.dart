import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
    );
  }
}

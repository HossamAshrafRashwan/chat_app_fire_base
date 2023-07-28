import 'package:flutter/material.dart';

class MYTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputAction textInputAction;

  const MYTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        fillColor: const Color.fromRGBO(34, 35, 44, 1),
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.green),
      ),
    );
  }
}

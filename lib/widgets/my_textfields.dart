import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final int? maxLength;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final TextEditingController controller;


  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      this.icon,
      this.maxLength,});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
      labelStyle: TextStyle(color: Colors.black),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
        suffixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      obscureText: obscureText,
    );
  }
}

// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

import '../../../constants/app_style.dart';
import '../../../constants/color.palette.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final bool obscure;
  final double dimension;
  final String textFieldValue;
  final String? errorMessage;
  final IconData? iconValue;
  final bool? enabled;
  final TextEditingController? textController;
  // ignore: prefer_const_constructors_in_immutables
  CustomTextField(
      {required this.hint,
      required this.textFieldValue,
      this.obscure = false,
      this.dimension = 15,
      this.enabled = true,
      this.textController,
      this.errorMessage,
      this.iconValue,
      super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState(hint, obscure,
      dimension, textController, errorMessage, enabled, iconValue);
}

class _CustomTextFieldState extends State<CustomTextField> {
  final String hint;
  bool? obscure;
  double? dimension;
  TextEditingController? textController;
  String? errorMessage;
  bool? enabled;
  IconData? iconValue;
  _CustomTextFieldState(this.hint, this.obscure, this.dimension,
      this.textController, this.errorMessage, this.enabled, this.iconValue);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      keyboardType: TextInputType.text,
      style: AppStyle.txt15grey500,
      controller: textController,
      decoration: InputDecoration(
        suffixIcon: iconValue != null ? Icon(iconValue!) : null,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.50, color: textFieldBorder),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        filled: true,
        fillColor: textFieldColor,
        border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.50, color: blackColor),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      obscureText: obscure!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        if (value.length > 50) {
          return '${widget.textFieldValue} must be less than 50 characters';
        }
        return null;
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants/color.palette.dart';

class CustomLabel extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  const CustomLabel(
      {required this.text,
      this.fontSize = 15,
      this.fontColor = blackColor,
      super.key});

  @override
  State<CustomLabel> createState() => _CustomLabelState();
}

class _CustomLabelState extends State<CustomLabel> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(fontSize: widget.fontSize, color: widget.fontColor),
    );
  }
}

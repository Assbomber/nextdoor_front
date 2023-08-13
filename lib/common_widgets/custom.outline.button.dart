import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.title,
    required this.textColor,
    required this.buttonBackground,
    required this.callback,
  });
  final String title;
  final Color textColor;
  final Color buttonBackground;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: buttonBackground,
        elevation: 0,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        // minimumSize: const Size.fromHeight(50),
      ),
      onPressed: callback,
      child: Text(title),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nextdoor_front/constants/color_%20palette.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.textColor,
    required this.buttonBackground,
    required this.callback,
  });
  final double width;
  final double height;
  final String title;
  final Color textColor;
  final Color buttonBackground;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding:
            const EdgeInsets.only(left: 150, right: 150, top: 15, bottom: 15),
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

import 'package:flutter/material.dart';
import 'package:nextdoor_front/constants/color_%20palette.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding:
            const EdgeInsets.only(left: 160, right: 160, top: 15, bottom: 15),
        backgroundColor: buttonBackground,
        elevation: 0,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        // minimumSize: const Size.fromHeight(50),
      ),
      onPressed: callback,
      child: Text(title),
    );

    // Container(
    //   alignment: Alignment(0, 0),
    //   width: width,
    //   height: height,
    //   decoration: BoxDecoration(
    //     color: buttonBackground,
    //     border: Border.all(color: blackColor, style: BorderStyle.solid),
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(8),
    //     ),
    //   ),
    //   child: Text(
    //     title,
    //     textAlign: TextAlign.center,
    //     style: TextStyle(
    //       color: textColor,
    //       fontSize: 15,
    //       fontWeight: FontWeight.w600,
    //     ),
    //   ),
    // );
  }
}

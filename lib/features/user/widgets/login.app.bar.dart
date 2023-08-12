import 'package:flutter/material.dart';

import '../../../constants/color.palette.dart';

class LoginAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  const LoginAppbar({this.backgroundColor = Colors.transparent, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      bottomOpacity: 0.0,
      elevation: 0.0,
      // New parameter:
      scrolledUnderElevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: blackColor,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:nextdoor_front/constants/color_%20palette.dart';

class LoginAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      bottomOpacity: 0.0,
      elevation: 0.0,
      // New parameter:
      scrolledUnderElevation: 0,
      leading: Container(
        // padding: EdgeInsets.all(0),
        // decoration: BoxDecoration(
        //   border: Border.all(color: blackColor),
        //   borderRadius: BorderRadius.all(Radius.circular(8)),
        // ),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: blackColor,
            )),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'features/user/screens/user_first_time_detail.dart';
import 'utils/utils.dart';
import 'features/user/screens/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getToken('token'),
        builder: (BuildContext context, AsyncSnapshot tokenSnapshot) {
          if (tokenSnapshot.hasData) {
            return const UserFirstimeDetail();
          }
          return const Login();
        });
  }
}

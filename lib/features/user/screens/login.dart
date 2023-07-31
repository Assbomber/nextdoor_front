import 'package:flutter/material.dart';
import 'package:nextdoor_front/common_widgets/CustomElevatedButton.dart';
import 'package:nextdoor_front/common_widgets/CustomOutlinedButton.dart';
import 'package:nextdoor_front/constants/color_%20palette.dart';
import 'package:nextdoor_front/features/user/screens/login_page.dart';
import 'package:nextdoor_front/features/user/screens/register_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: const Alignment(0, 0),
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/image1.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
              top: 400,
              child: Container(
                child: Column(
                  children: [
                    Image.asset('assets/images/logo_icon.png'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('MyZone'),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomElevatedButton(
                        width: 331,
                        height: 56,
                        title: 'Login',
                        textColor: whiteColor,
                        buttonBackground: blackColor,
                        callback: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            )),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomOutlinedButton(
                      width: 331,
                      height: 56,
                      title: 'Register',
                      textColor: blackColor,
                      buttonBackground: whiteColor,
                      callback: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Continue as a guest',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF34C2C1),
                        fontSize: 15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

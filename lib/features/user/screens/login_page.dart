import 'package:flutter/material.dart';
import 'package:nextdoor_front/common_widgets/CustomElevatedButton.dart';
import 'package:nextdoor_front/constants/app_style.dart';
import 'package:nextdoor_front/constants/color_%20palette.dart';
import 'package:nextdoor_front/features/feed/screens/home.dart';
import 'package:nextdoor_front/features/user/screens/Login_otp_verification.dart';
import 'package:nextdoor_front/features/user/widgets/LoginAppbar.dart';
import 'package:nextdoor_front/services/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const LoginAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const Text(
                'Welcome back! Glad to see you, Again!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldColor,
                  hintText: "Enter Your Email",
                  hintStyle: AppStyle.txt15grey500,
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.50, color: textFieldBorder),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: passwordVisible,
                controller: passwordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldColor,
                  hintText: "Enter Your Password",
                  hintStyle: AppStyle.txt15grey500,
                  // hintStyle: h14InputTextHint,
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.50, color: textFieldBorder),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Your Password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot Password'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomElevatedButton(
                      title: 'Login',
                      textColor: whiteColor,
                      buttonBackground: blackColor,
                      callback: () async {
                        setState(() {
                          isLoading = true;
                        });
                        var response = await ApiService().loginUser(
                            emailController.text, passwordController.text);
                        if (response.statusCode == 201) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('User LogedIn Successfully'),
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Something went wrong')),
                          );
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don’t have an account? ",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            InkWell(
              onTap: () {
                print('Text Clicked');
              },
              child: const Text(
                'Register Now',
                style: TextStyle(
                  color: Color(0xFF34C2C1),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nextdoor_front/common_widgets/CustomElevatedButton.dart';
import 'package:nextdoor_front/constants/color_%20palette.dart';
import 'package:nextdoor_front/features/user/screens/login_otp_verification.dart';
import 'package:nextdoor_front/features/user/screens/login_page.dart';
import 'package:nextdoor_front/features/user/widgets/LoginAppbar.dart';
import 'package:nextdoor_front/services/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const Text(
                'Hello! Register to get started',
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
                controller: usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: textFieldColor,
                  hintText: "Username",
                  // hintStyle: h14InputTextHint,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.50, color: textFieldBorder),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: emailController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: textFieldColor,
                  hintText: "Enter Your Email",
                  // hintStyle: h14InputTextHint,
                  border: OutlineInputBorder(
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
                  hintText: "Password",
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
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: passwordVisible,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldColor,
                  hintText: "Confirm Password",
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
                    return 'Please enter Your Comfirm Password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomElevatedButton(
                      title: 'Register',
                      textColor: whiteColor,
                      buttonBackground: blackColor,
                      callback: () async {
                        setState(() {
                          isLoading = true;
                        });
                        print("In Register");
                        var response = await ApiService()
                            .emailVerification(emailController.text);
                        if (response.statusCode == 201) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('OTP Sent Successfully')),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginOtpVerification(
                                email: emailController.text,
                                password: passwordController.text,
                                username: usernameController.text,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Something went wrong')),
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }),
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
              "Already have an account? ",
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
                'Login',
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

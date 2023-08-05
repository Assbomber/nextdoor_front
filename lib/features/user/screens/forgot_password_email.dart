import 'package:flutter/material.dart';
import 'package:nextdoor_front/common_widgets/CustomElevatedButton.dart';
import 'package:nextdoor_front/constants/app_style.dart';
import 'package:nextdoor_front/constants/color_%20palette.dart';
import 'package:nextdoor_front/features/user/screens/forgot_password.dart';
import 'package:nextdoor_front/features/user/widgets/LoginAppbar.dart';
import 'package:nextdoor_front/services/api_service.dart';
import 'package:nextdoor_front/utils/response_handler.dart';

class ForgotPasswordEmail extends StatefulWidget {
  const ForgotPasswordEmail({super.key});

  @override
  State<ForgotPasswordEmail> createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Don't worry! It occurs. Please enter the email address linked with your account.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
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
                    const pattern =
                        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                    final regex = RegExp(pattern);

                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomElevatedButton(
                        title: 'Send Code',
                        textColor: whiteColor,
                        buttonBackground: blackColor,
                        callback: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            var response = await ApiService()
                                .emailVerification(emailController.text);
                            if (response is Failure) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text(response.exception.toString())),
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response.value)),
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword(
                                        email: emailController.text)),
                              );
                            }

                            // var response = await ApiService().loginUser(
                            //     emailController.text, passwordController.text);
                            // if (response is Failure) {
                            //   // ignore: use_build_context_synchronously
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //         content:
                            //             Text(response.exception.toString())),
                            //   );
                            // } else {
                            //   // ignore: use_build_context_synchronously
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       content: Text(response.value),
                            //     ),
                            //   );
                            //   // ignore: use_build_context_synchronously
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const Home()),
                            //   );
                            // }
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

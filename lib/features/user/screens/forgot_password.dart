import 'package:flutter/material.dart';
import '../../../common_widgets/custom.elevated.button.dart';
import '../../../constants/app_style.dart';
import '../../../constants/color.palette.dart';
import 'login_page.dart';
import '../widgets/login.app.bar.dart';
import '../../../services/api_service.dart';
import '../../../utils/response_handler.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key, required this.email});

  final String email;

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

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
                const Text(
                  'Create new password',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Your new password must be unique from those previously used.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: passwordVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: 'New Password',
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
                      return 'Please enter Your New Password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
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
                    hintText: 'Confirm Password',
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
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      return 'New Password and Confirm Password must be the same';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: otpController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: 'Enter Your OTP',
                    hintStyle: AppStyle.txt15grey500,
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.50, color: textFieldBorder),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter OTP';
                    }

                    if (value.length != 6) {
                      return 'OTP must be 6 numbers';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomElevatedButton(
                        title: 'Reset Password',
                        textColor: whiteColor,
                        buttonBackground: blackColor,
                        callback: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            var response = await ApiService().resetUserPassword(
                                widget.email,
                                passwordController.text,
                                int.parse(otpController.text));
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
                                SnackBar(
                                  content: Text(response.value),
                                ),
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            }
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

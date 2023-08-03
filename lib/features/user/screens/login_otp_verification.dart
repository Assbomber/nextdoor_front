import 'package:flutter/material.dart';
import 'package:nextdoor_front/common_widgets/CustomElevatedButton.dart';
import 'package:nextdoor_front/constants/color_%20palette.dart';
import 'package:nextdoor_front/features/user/screens/login_page.dart';
import 'package:nextdoor_front/features/user/widgets/LoginAppbar.dart';
import 'package:nextdoor_front/features/user/widgets/OtpInput.dart';
import 'package:nextdoor_front/services/api_service.dart';

class LoginOtpVerification extends StatefulWidget {
  const LoginOtpVerification({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });
  final String username;
  final String password;
  final String email;

  @override
  State<LoginOtpVerification> createState() => _LoginOtpVerificationState();
}

class _LoginOtpVerificationState extends State<LoginOtpVerification> {
  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enter the verification code we just sent on your email address.',
                style: TextStyle(
                  fontSize: 16,
                  color: forgotPasswordTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OtpInput(_fieldOne, true), // auto focus
                  OtpInput(_fieldTwo, false),
                  OtpInput(_fieldThree, false),
                  OtpInput(_fieldFour, false),
                  OtpInput(_fieldFive, false),
                  OtpInput(_fieldSix, false)
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomElevatedButton(
                      title: 'Verify',
                      textColor: whiteColor,
                      buttonBackground: blackColor,
                      callback: () async {
                        setState(() {
                          isLoading = true;
                        });
                        var otp = _fieldOne.text +
                            _fieldTwo.text +
                            _fieldThree.text +
                            _fieldFour.text +
                            _fieldFive.text +
                            _fieldSix.text;

                        var response = await ApiService().registerUser(
                            widget.email,
                            widget.username,
                            int.parse(otp),
                            widget.password);

                        if (response.statusCode == 200) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('User Registered Successfully'),
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
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
              "Didn’t received code? ",
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
                'Resend',
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

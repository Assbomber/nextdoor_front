import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../common_widgets/custom.elevated.button.dart';
import '../../../constants/color.palette.dart';
import '../../../services/location_service.dart';
import '../widgets/custom.label.dart';
import '../widgets/image_selector.dart';

class UserFirstimeDetail extends StatefulWidget {
  const UserFirstimeDetail({super.key});

  @override
  State<UserFirstimeDetail> createState() => _UserFirstimeDetailState();
}

class _UserFirstimeDetailState extends State<UserFirstimeDetail> {
  String profilePicBase64 = '';
  getImageCallback(String value) {
    setState(() {
      profilePicBase64 = value;
    });
  }

  String gender = '';
  bool locationLoader = false;
  String? latitude;
  String? longitude;
  TextEditingController currentLocation = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String countryCode = 'IN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const HSLColor.fromAHSL(1, 212, 0.35, 0.58).toColor(),
                const HSLColor.fromAHSL(1, 218, 0.32, 0.80).toColor(),
              ],
            ),
          ),
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
          child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const HSLColor.fromAHSL(1, 212, 0.35, 0.58).toColor(),
                      const HSLColor.fromAHSL(1, 218, 0.32, 0.80).toColor(),
                    ],
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Center(
                    child: SelectImage(
                      callback: getImageCallback,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLabel(
                        text: 'Current Location',
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Stack(
                          children: [
                            TextFormField(
                              enabled: false,
                              controller: currentLocation,
                              style: const TextStyle(
                                  color: blackColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: textFieldFilledColor,
                                hintText: 'New Delhi',
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                hintStyle: const TextStyle(
                                  fontSize: 12,
                                  height: 1,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your charge point location';
                                }
                                return null;
                              },
                              textAlignVertical: TextAlignVertical
                                  .center, // Center the text vertically
                            ),
                            IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    color: Colors.transparent), // Hide the text
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 0,
                              child: locationLoader
                                  ? Container(
                                      margin: const EdgeInsets.all(10),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 1.5,
                                        color: blackColor,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          locationLoader = true;
                                        });
                                        var response =
                                            await getCurrentPosition();
                                        if (response['status'] == 'success') {
                                          setState(() {
                                            latitude = response['latitude']!;
                                            longitude = response['longitude']!;
                                            currentLocation.text = response[
                                                'subAdministrativeArea']!;
                                          });
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    response['message']!
                                                        .toString())),
                                          );
                                        }
                                        setState(() {
                                          locationLoader = false;
                                        });
                                      },
                                      icon: const Icon(Icons.gps_fixed_rounded),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const CustomLabel(text: 'Phone Number'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: IntlPhoneField(
                          controller: phoneNumber,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: textFieldFilledColor,

                            hintText: '7700900000',
                            hintStyle: const TextStyle(fontSize: 15),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                    width: 1, color: textFieldBorder)),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide:
                                  BorderSide(width: 1, color: textFieldBorder),
                            ),
                            // labelText: 'Phone Number',
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            setState(() {
                              countryCode = phone.countryISOCode;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const CustomLabel(text: 'Gender'),
                      ),
                      RadioListTile(
                        title: const Text('Male'),
                        value: 'male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text('Female'),
                        value: 'female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text('Other'),
                        value: 'other',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: CustomElevatedButton(
                    title: 'Save',
                    textColor: blackColor,
                    buttonBackground: textFieldFilledColor,
                    callback: () {}),
              )
            ],
          ),
        ),
      )),
    );
  }
}

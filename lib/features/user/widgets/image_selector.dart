import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/color.palette.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key, required this.callback, this.profilePic = ''});
  final Function(String val) callback;
  final String? profilePic;

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  String? profilePicBase64;

  @override
  void initState() {
    super.initState();
    setState(() {
      profilePicBase64 = widget.profilePic;
    });
  }

  void showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                hoverColor: forgotPasswordTextColor,
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  getImage(ImageSource.gallery, context);
                  // Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera, context);
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource imgSource, BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      if (sizeInMb > 10 && context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image is too large'),
          ),
        );
        widget.callback('');
        setState(() {
          profilePicBase64 = '';
        });
        return null;
      } else {
        List<int> fileInByte = file.readAsBytesSync();
        String fileInBase64 = base64Encode(fileInByte);
        widget.callback(fileInBase64);
        setState(() {
          profilePicBase64 = fileInBase64;
        });
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        return fileInBase64;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPicker(context: context),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: profilePicBase64 == '' ? textFieldBorder : null,
        backgroundImage: profilePicBase64 == ''
            ? Image.asset(
                'assets/images/avatar.png',
              ).image
            : Image.memory(
                base64Decode(profilePicBase64!),
                fit: BoxFit.cover,
              ).image,
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:dramatic_outputs/reusable/image_rounded_rect.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerColumn extends StatefulWidget {
  const ImagePickerColumn(
      {super.key, required this.onCheckPressed, required this.onImageSelected});
  final VoidCallback onCheckPressed;
  final Function(File) onImageSelected;
  @override
  ImagePickerColumnState createState() => ImagePickerColumnState();
}

class ImagePickerColumnState extends State<ImagePickerColumn> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
              onTap: _pickImage,
              child: ImageRoundedRect(
                image: _image,
                onCheckPressed: widget.onCheckPressed,
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:dramatic_outputs/reusable/image_rounded_rect.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerColumn extends StatefulWidget {
  const ImagePickerColumn({super.key, required this.onCheckPressed});
  final VoidCallback onCheckPressed;
  @override
  ImagePickerColumnState createState() => ImagePickerColumnState();
}

class ImagePickerColumnState extends State<ImagePickerColumn> {
  File? _image;

  Future<void> _sendImageToApi(File? imageFile) async {
    final dio = Dio();
    if (imageFile == null) {
      return;
    } else {
      final formData = FormData.fromMap({
        'imagefile': await MultipartFile.fromFile(imageFile.path),
      });

      try {
        final response = await dio.post(
          'https://yourapi.com/upload', // Replace with your API URL
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        if (response.statusCode == 200) {
          print('Image uploaded successfully');
        } else {
          print('Failed to upload image: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
    // Form the data
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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

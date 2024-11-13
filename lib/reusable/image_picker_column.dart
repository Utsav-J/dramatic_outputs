import 'package:dramatic_outputs/reusable/image_rounded_rect.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerColumn extends StatefulWidget {
  @override
  _ImagePickerColumnState createState() => _ImagePickerColumnState();
}

class _ImagePickerColumnState extends State<ImagePickerColumn> {
  File? _image;
  // String? _labels; // To store the response labels

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        // _labels = null; // Reset labels when a new image is selected
      });
      // await _uploadImage(_image!); // Upload the selected image
    }
  }

  // Future<void> _uploadImage(File imageFile) async {
  //   final dio = Dio();
  //   const String url =
  //       'http://localhost:5000/process_image'; // Use your server IP if testing on a real device

  //   try {
  //     FormData formData = FormData.fromMap({
  //       'image': await MultipartFile.fromFile(imageFile.path,
  //           filename: 'selected_image.jpg'),
  //     });

  //     Response response = await dio.post(url, data: formData);

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         _labels =
  //             response.data.toString(); // Update the labels with response data
  //       });
  //     } else {
  //       setState(() {
  //         _labels = 'Error: ${response.statusMessage}';
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _labels = 'Failed to upload image: $e';
  //     });
  //   }
  // }

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
              )),
          const SizedBox(height: 20),

          // ClipRRect(
          //   borderRadius: BorderRadius.circular(25),
          //   child: _labels == null
          //       ? const Text(
          //           'No image selected.',
          //           style: TextStyle(color: Colors.white),
          //         )
          //       : Text(
          //           'Labels: $_labels',
          //           style: const TextStyle(color: Colors.white),
          //         ),
          // ),
        ],
      ),
    );
  }
}

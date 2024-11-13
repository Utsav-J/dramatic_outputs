import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

Future<void> uploadImage(File imageFile) async {
  final dio = Dio();
  String url =
      'http://localhost:5000/process_imagefile'; // Use the server's IP if testing on a real device

  try {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path,
          filename: 'selected_image.jpg'),
    });

    Response response = await dio.post(url, data: formData);

    if (response.statusCode == 200) {
      print('Processed JSON: ${response.data}');
    } else {
      print('Error: ${response.statusMessage}');
    }
  } catch (e) {
    print('Failed to upload image: $e');
  }
}

Future<void> pickAndUploadImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    File imageFile = File(image.path);
    await uploadImage(imageFile);
  }
}

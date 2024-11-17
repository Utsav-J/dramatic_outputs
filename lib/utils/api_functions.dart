import "dart:io";
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

class ApiFunctions {
  static String baseUrl = "https://9e24-34-16-248-148.ngrok-free.app";
  static String getLabelEndpoint = "/upload-image/";

  Future<Map<String, dynamic>> getLabelRequest(File imageFile) async {
    try {
      // Create Dio instance
      Dio dio = Dio();

      // Create form data
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: MediaType("image", "jpg"), // Adjust as needed
        ),
      });

      // Send POST request
      Response response = await dio.post(
        baseUrl + getLabelEndpoint,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      // Check response status and return the response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            "Failed to upload image: ${response.statusCode} - ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Error occurred while uploading image: $e");
    }
  }
}

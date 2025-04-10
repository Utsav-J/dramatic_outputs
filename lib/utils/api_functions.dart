import "dart:io";
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:dio/dio.dart';

class ApiFunctions {
  static String baseUrl = "https://placeholder.url";
  static String getLabelEndpoint = "/upload-image/";
  static String getImagesEndpoint = "/select-label/";

  static Future<void> fetchBackendUrl() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      // Set minimum fetch interval to 0 to always fetch fresh values
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(
          milliseconds: 0,
        ), // Allow fetching every time
      ));

      // Force a fetch and activate
      bool updated = await remoteConfig.fetchAndActivate();
      baseUrl = remoteConfig.getString("backend_url");
      print("Config fetch status: $updated");
      print("Updated baseURL: $baseUrl");
    } catch (e) {
      print("Error fetching backend URL: $e");
    }
  }

  Dio dio = Dio();

  Future<Map<String, dynamic>> getLabelRequest(File imageFile) async {
    try {
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

  Future<List<String>> selectLabel({
    required String filename,
    required int labelIndex,
    required String level, // Add this parameter
  }) async {
    try {
      // Build the URL with the query parameter
      final String url = '$baseUrl$getImagesEndpoint?filename=$filename';

      // Create the raw JSON input with the new "level" field
      final Map<String, dynamic> data = {
        "label_index": labelIndex,
        "level": level, // Include the level parameter
      };

      // Send POST request
      final Response response = await dio.post(
        url,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Check for success response
      if (response.statusCode == 200) {
        print("API Call Successful: ${response.data}");

        // Parse the Base64 images from the response
        List<String> base64Images =
            List<String>.from(response.data['output_images_base64']);

        // Handle the Base64 images as needed
        return base64Images;
      } else {
        print("API Call Failed: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error during API call: $e");
      return [];
    }
  }
}

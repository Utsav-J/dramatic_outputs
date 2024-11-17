import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class UtilFunctions {
  static List<String> extractLabelsFromJson(Map<String, dynamic> jsonData) {
    print(jsonData);
    List<dynamic> dynamicLabels =
        jsonData['json_data']['<CAPTION_TO_PHRASE_GROUNDING>']['labels'];
    List<String> listOfLabels =
        dynamicLabels.map((label) => label.toString()).toList();
    // List<String> listOfLabels =
    //     jsonData['json_data']['<CAPTION_TO_PHRASE_GROUNDING>']['labels'];
    Set<String> uniqueLabels = Set.from(listOfLabels);
    // print(listOfLabels);
    // print(uniqueLabels);
    return uniqueLabels.toList();
  }

  static String extractImageCaption(Map<dynamic, dynamic> jsonData) {
    String imageCaption = jsonData['json_data']['<MORE_DETAILED_CAPTION>'];
    return imageCaption.toString();
  }

  static String generateUniqueFeedbackId() {
    var uuid = const Uuid();
    String feedbackId = uuid.v4();
    print(feedbackId);
    return feedbackId;
  }

  static Future<void> handleDownloadImage(
      Uint8List imageData, BuildContext context) async {
    try {
      // Get the application's documents directory to save the image
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/downloaded_image.jpg';

      // Save the image bytes to a file
      final file = File(filePath);
      await file.writeAsBytes(imageData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image saved to: $filePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Download failed: $e")),
      );
    }
  }
}

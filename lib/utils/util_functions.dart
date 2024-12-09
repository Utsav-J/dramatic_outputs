import 'dart:io';
import 'dart:typed_data';
import 'package:app_linkster/app_linkster.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
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

  static Map<String, int> extractLabelsWithIndex(
      Map<String, dynamic> jsonData) {
    List<dynamic> dynamicLabels =
        jsonData['json_data']['<CAPTION_TO_PHRASE_GROUNDING>']['labels'];
    List<String> listOfLabels =
        dynamicLabels.map((label) => label.toString()).toList();

    Map<String, int> uniqueLabelsWithIndices = {};

    for (int i = 0; i < listOfLabels.length; i++) {
      if (!uniqueLabelsWithIndices.containsKey(listOfLabels[i])) {
        uniqueLabelsWithIndices[listOfLabels[i]] =
            i + 1; // Store 1-indexed position
      }
    }

    return uniqueLabelsWithIndices;
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

  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      // Check for storage permission
      if (await Permission.storage.isGranted) {
        return true;
      }

      // For Android 11+ also check manage external storage permission
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      }

      // Request permissions
      if (await Permission.storage.request().isGranted) {
        return true;
      }

      if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }

      return false;
    }
    return true;
  }

  static Future<void> handleDownloadImage(
      Uint8List imageData, BuildContext context) async {
    try {
      // Request storage permissions for Android
      if (Platform.isAndroid) {
        final hasPermission = await requestStoragePermission();
        if (!hasPermission) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Storage permission is required.")),
          );
          return;
        }
      }

      // Define the Downloads folder path
      const downloadsPath = '/storage/emulated/0/Download';
      DateTime now = DateTime.now();
      final String formattedTime =
          "${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}";
      final filePath = '$downloadsPath/downloaded_image_$formattedTime.jpg';

      // Save the file
      final file = File(filePath);
      await file.writeAsBytes(imageData);

      print("Image saved to Downloads: $filePath");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image saved to Downloads: $filePath")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Download failed: $e")),
        );
      }
    }
  }

  static String extractFilenameFromJson(Map<String, dynamic> jsonData) {
    String filename = jsonData["filename"];
    return filename;
  }

  static void openInstagramProfile() async {
    const String instagramUsername = 'acoolstick_';
    final Uri instagramWebUri =
        Uri.parse('https://www.instagram.com/$instagramUsername');

    final launcher = AppLinksterLauncher();
    await launcher.launchThisGuy(
      instagramWebUri.toString(),
      fallbackLaunchMode: LaunchMode.externalApplication,
    );
  }

  static void openLinkedinProfile(String username) async {
    final Uri linkedinWebUri =
        Uri.parse('https://www.linkedin.com/in/$username/');
    final launcher = AppLinksterLauncher();
    await launcher.launchThisGuy(
      linkedinWebUri.toString(),
      fallbackLaunchMode: LaunchMode.externalApplication,
    );
  }
}

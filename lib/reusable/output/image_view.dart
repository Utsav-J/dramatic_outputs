import 'package:dramatic_outputs/reusable/output/feedback_button.dart';
import 'package:dramatic_outputs/screens/full_screen_image.dart';
import 'package:dramatic_outputs/utils/util_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
    required this.imagePath,
    required this.imageData,
    required this.onReset,
  });
  final Image imagePath;
  final VoidCallback onReset;
  final Uint8List imageData;

  Future<void> handleDownloadImage(BuildContext context) async {
    try {
      // Call the function to save the image
      await UtilFunctions.handleDownloadImage(imageData, context);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving image: $e")),
        );
      }
    }
  }

  Future<String> uploadDislikedImage(Uint8List imageData) async {
    try {
      final supabase = Supabase.instance.client;

      // Generate a unique filename
      String uniqueId = const Uuid().v4();
      String fileName = "disliked_images/$uniqueId.jpg";

      // Upload image to Supabase Storage
      final String? filePath = await supabase.storage
          .from('dislikedOutputImages')
          .uploadBinary(fileName, imageData,
              fileOptions: const FileOptions(
                contentType: 'image/jpeg',
              ));
      if (filePath != null && filePath.isNotEmpty) {
        // Get the public URL of the uploaded image
        // final publicURL = supabase.storage
        //     .from('dislikedOutputImages')
        //     .getPublicUrl(filePath);
        const String supabaseStorageUrl =
            "https://gbkbgnpcuvdvoqjfsocb.supabase.co/storage/v1/object/public/";
        final String publicURL = "$supabaseStorageUrl$filePath";
        // print("Image uploaded successfully: $publicURL");
        print(
            "_________________________________________________________________________________________________");
        // final publicURL =
        //     "https://gbkbgnpcuvdvoqjfsocb.supabase.co/storage/v1/object/public/dislikedOutputImages/dislikedOutputImages/disliked_images/${uniqueId}.jpg";
        return publicURL;
      } else {
        throw Exception("Upload failed: File path is null or empty.");
      }
    } catch (e) {
      print("Error uploading image to Supabase: $e");
    }
    return "";
  }

  Future<void> downloadWatermarkedImage(
      Uint8List imageBytes, BuildContext context) async {
    const String watermarkText = "      AI\nGenerated";

    try {
      // Decode the image
      final img.Image? originalImage = img.decodeImage(imageBytes);
      if (originalImage == null) {
        throw Exception("Failed to decode the image.");
      }

      // Define text style
      final img.BitmapFont font =
          img.arial24; // Use a built-in font (adjust size as needed)

      // Add watermark text
      img.drawString(
        originalImage,
        font: font,
        x: 20, // X position
        y: 30, // Y position
        watermarkText,
        color: img.ColorRgb8(200, 200, 200),
      );

      // Encode the watermarked image
      final Uint8List watermarkedImageBytes =
          Uint8List.fromList(img.encodeJpg(originalImage));

      // Save or download the image
      if (context.mounted) {
        await UtilFunctions.handleDownloadImage(watermarkedImageBytes, context);
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Image with watermark saved successfully.")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error adding watermark: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  // Draw the image first so the button appears on top
                  GestureDetector(
                    onTap: () => _showFullScreenImage(context),
                    child: Hero(
                      tag: imageData,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: SizedBox(
                          height: 300, // Define a fixed height
                          width: double.infinity, // Use full width
                          child:
                              imagePath, // Ensure `imagePath` respects constraints
                        ),
                      ),
                    ),
                  ),
                  // Then, position the button on top of the image
                  Positioned(
                    bottom: 8,
                    right: 15,
                    child: GestureDetector(
                      onTap: () {
                        downloadWatermarkedImage(imageData, context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.save_sharp,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FeedbackButton(
                    isLike: true,
                    uploadDislikedImage: uploadDislikedImage,
                  ),
                  const SizedBox(
                    height: 30, // Set the height of the divider as needed
                    child: VerticalDivider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 1, // Set the thickness of the divider
                      width: 20, // Space between the divider and the buttons
                    ),
                  ),
                  FeedbackButton(
                    isLike: false,
                    uploadDislikedImage: uploadDislikedImage,
                    imageData: imageData,
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onReset,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(
                Colors.white24,
              ),
            ),
            child: const Text(
              "New Session",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFullScreenImage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // Makes the background transparent
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: FullScreenImage(imageData: imageData),
          );
        },
      ),
    );
  }
}

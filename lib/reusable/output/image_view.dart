import 'package:dramatic_outputs/reusable/output/feedback_button.dart';
import 'package:dramatic_outputs/utils/util_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageView extends StatelessWidget {
  const ImageView(
      {super.key, required this.imagePath, required this.imageData});
  final Image imagePath;
  final Uint8List imageData;

  Future<void> handleDownloadImage(BuildContext context) async {
    try {
      // Call the function to save the image
      await UtilFunctions.handleDownloadImage(imageData, context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving image: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              // Draw the image first so the button appears on top
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: imagePath,
              ),
              // Then, position the button on top of the image
              Positioned(
                bottom: 8,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    handleDownloadImage(
                      context,
                    );
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FeedbackButton(
                isLike: true,
              ),
              SizedBox(
                height: 30, // Set the height of the divider as needed
                child: VerticalDivider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 1, // Set the thickness of the divider
                  width: 20, // Space between the divider and the buttons
                ),
              ),
              FeedbackButton(
                isLike: false,
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:dramatic_outputs/reusable/feedback_button.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.imagePath});
  final Image imagePath;

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
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: imagePath,
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

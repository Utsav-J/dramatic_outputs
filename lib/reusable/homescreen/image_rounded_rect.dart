import 'dart:io';
import 'package:flutter/material.dart';

class ImageRoundedRect extends StatelessWidget {
  const ImageRoundedRect({
    super.key,
    required this.image,
    required this.onCheckPressed,
  });
  final File? image;
  final VoidCallback onCheckPressed;

  @override
  Widget build(BuildContext context) {
    return image == null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              'assets/images/image_placeholder.png',
              height: 300,
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.cover,
            ),
          )
        : Stack(
            children: [
              // Draw the image first so the button appears on top
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.file(
                  image!,
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover,
                ),
              ),
              // Then, position the button on top of the image
              Positioned(
                bottom: 8,
                right: 15,
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: onCheckPressed,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 24.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

import 'dart:convert';
import 'package:dramatic_outputs/reusable/output/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutputImageGallery extends StatelessWidget {
  final List<String> outputImages;
  final VoidCallback onReset;
  const OutputImageGallery({
    super.key,
    required this.outputImages,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    if (outputImages.isEmpty) {
      return const Center(
        child: Text(
          "No images generated yet.\nPress on the original image to start a new session.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: outputImages.length,
      itemBuilder: (context, index) {
        return FutureBuilder<Uint8List>(
          future: _decodeBase64Image(outputImages[index]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.red,
                ),
              );
            } else if (snapshot.hasData) {
              return ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  minHeight: 0,
                ),
                child: ImageView(
                  imageData: snapshot.data!,
                  imagePath: Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
                  onReset: onReset,
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "Image unavailable",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<Uint8List> _decodeBase64Image(String base64String) async {
    return base64Decode(base64String);
  }
}

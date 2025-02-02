import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final Uint8List imageData;

  const FullScreenImage({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context), // Close on tap
        child: Center(
          child: Hero(
            tag: imageData,
            child: PhotoView(
              imageProvider: MemoryImage(imageData),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 2,
            ),
          ),
        ),
      ),
    );
  }
}

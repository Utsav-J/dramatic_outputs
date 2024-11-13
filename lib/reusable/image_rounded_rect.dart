import 'dart:io';

import 'package:flutter/material.dart';

class ImageRoundedRect extends StatelessWidget {
  const ImageRoundedRect({super.key, required this.image});
  final File? image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: image == null
          ? Image.asset(
              'assets/images/image_placeholder.png',
              height: 300,
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.cover,
            )
          : Image.file(
              image!,
              height: 300,
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.cover,
            ),
    );
  }
}

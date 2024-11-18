import 'dart:io';
import 'dart:typed_data';
import 'package:dramatic_outputs/reusable/homescreen/captionText.dart';
import 'package:dramatic_outputs/reusable/homescreen/home_screen_drawer.dart';
import 'package:dramatic_outputs/reusable/homescreen/image_picker_column.dart';
import 'package:dramatic_outputs/reusable/output/image_view.dart';
import 'package:dramatic_outputs/reusable/homescreen/label_picker.dart';
import 'package:dramatic_outputs/utils/api_functions.dart';
import 'package:dramatic_outputs/utils/random_image_request.dart';
import 'package:dramatic_outputs/utils/util_functions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map<String, dynamic>>? randomImageFuture;
  List<String> uniqueLabels = [];
  bool isLoading = false;
  final response = {};
  File? selectedImage;

  Future<void> updateLabels(File imageFile) async {
    setState(() {
      isLoading = true;
    });

    try {
      final apiFunctions = ApiFunctions();
      final apiResponse = await apiFunctions.getLabelRequest(imageFile);
      List<String> extractedLabels =
          UtilFunctions.extractLabelsFromJson(apiResponse);

      setState(() {
        uniqueLabels = extractedLabels;
        response.clear();
        response.addAll(apiResponse);
        print("Updated response: $response");
      });
    } catch (e) {
      print("Error : $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch labels: $e')),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void handleLabelTap() {
    setState(() {
      randomImageFuture = generateRandomImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dramatic Outputs',
            style: TextStyle(color: Colors.white),
          ),
          // backgroundColor: const Color.fromARGB(255, 68, 41, 113),
        ),
        drawer: const HomeScreenDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImagePickerColumn(onCheckPressed: () {
                if (selectedImage != null) {
                  updateLabels(selectedImage!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select an image first!'),
                    ),
                  );
                }
              }, onImageSelected: (File image) {
                setState(() {
                  selectedImage = image;
                });
              }),
              isLoading == true
                  ? LinearProgressIndicator(
                      color: const Color.fromARGB(255, 47, 129, 100),
                      borderRadius: BorderRadius.circular(25),
                    )
                  : LabelPicker(
                      uniqueLabels: uniqueLabels,
                      onLabelTap: handleLabelTap,
                    ),
              const SizedBox(height: 10.0),
              response.isEmpty
                  ? const SizedBox()
                  : CaptionString(
                      caption: UtilFunctions.extractImageCaption(response),
                    ),
              FutureBuilder<Map<String, dynamic>>(
                future: randomImageFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Error loading image',
                      style: TextStyle(color: Colors.white),
                    );
                  } else if (snapshot.hasData) {
                    final image = snapshot.data!["image"] as Image;
                    final imageData = snapshot.data!["data"] as Uint8List;
                    return ImageView(imagePath: image, imageData: imageData);
                  } else {
                    return const Text(
                      'Press the button to load an image',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                },
              ),
              // FutureBuilder<Map<String, dynamic>>(
              //   future: generateRandomImage(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const CircularProgressIndicator(color: Colors.white);
              //     } else if (snapshot.hasError) {
              //       return const Text(
              //         'Error loading image',
              //         style: TextStyle(color: Colors.white),
              //       );
              //     } else if (snapshot.hasData) {
              //       final image = snapshot.data!["image"] as Image;
              //       final imageData = snapshot.data!["data"] as Uint8List;
              //       return ImageView(imagePath: image, imageData: imageData);
              //     } else {
              //       return const Text(
              //         'No image available',
              //         style: TextStyle(color: Colors.white),
              //       );
              //     }
              //   },
              // ),
              IconButton(
                onPressed: handleLabelTap,
                icon: Icon(Icons.save),
              )
            ],
          ),
        ));
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'package:dramatic_outputs/reusable/homescreen/caption_text.dart';
import 'package:dramatic_outputs/reusable/homescreen/image_picker_column.dart';
import 'package:dramatic_outputs/reusable/output/image_view.dart';
import 'package:dramatic_outputs/reusable/homescreen/home_screen_drawer.dart';
import 'package:dramatic_outputs/reusable/homescreen/label_picker.dart';
import 'package:dramatic_outputs/reusable/output/output_image_gallery.dart';
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
  Map<String, int> extractedLabelsWithIndices = {};
  bool isLoading = false;
  bool isLoadingOutput = false;
  Map<String, dynamic> response = {};
  File? selectedImage;
  String filename = "";
  List<String> outputImages = [];

  void resetState() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("New Session"),
        duration: Duration(seconds: 2),
      ),
    );
    setState(() {
      uniqueLabels.clear();
      extractedLabelsWithIndices.clear();
      response.clear();
      selectedImage = null;
      filename = "";
      outputImages.clear();
      isLoading = false;
      isLoadingOutput = false;
      randomImageFuture = null;
    });
  }

  Future<void> updateLabels(File imageFile) async {
    setState(() {
      isLoading = true;
    });

    try {
      final apiFunctions = ApiFunctions();
      final apiResponse = await apiFunctions.getLabelRequest(imageFile);
      // List<String> extractedLabels =
      //     UtilFunctions.extractLabelsFromJson(apiResponse);
      extractedLabelsWithIndices =
          UtilFunctions.extractLabelsWithIndex(apiResponse);
      List<String> extractedLabels = extractedLabelsWithIndices.keys.toList();
      String extractedFilename =
          UtilFunctions.extractFilenameFromJson(apiResponse);
      setState(() {
        uniqueLabels = extractedLabels;
        filename = extractedFilename;
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

  void handleLabelTap(int index, String fileName) async {
    setState(
      () {
        debugPrint("Button pressed for index: $index");
        isLoadingOutput = true; // Show loading state
      },
    );

    try {
      // Call the API
      final apiService = ApiFunctions();
      final List<String> images = await apiService.selectLabel(
        filename: fileName,
        labelIndex: index,
      );

      // Update state with output images
      setState(() {
        outputImages = images; // Update image results
        isLoadingOutput = false; // Remove loading state
      });
    } catch (e) {
      debugPrint("Error occurred: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occured: $e'),
          ),
        );
      }
      setState(() {
        isLoadingOutput = false; // Remove loading state on error
      });
    }
  }

  void handleLabelTapDebug() {
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
        ),
        drawer: const HomeScreenDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImagePickerColumn(
                onCheckPressed: () {
                  if (selectedImage != null) {
                    updateLabels(selectedImage!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select an image first!'),
                      ),
                    );
                  }
                },
                onImageSelected: (File image) {
                  setState(() {
                    selectedImage = image;
                  });
                },
                onReset: resetState, // Pass reset state callback
              ),
              isLoading == true
                  ? LinearProgressIndicator(
                      color: const Color.fromARGB(255, 47, 129, 100),
                      borderRadius: BorderRadius.circular(25),
                    )
                  : LabelPicker(
                      labelsWithIndices: extractedLabelsWithIndices,
                      onLabelTap: handleLabelTap,
                      currentFilename: filename,
                    ),
              const SizedBox(height: 10.0),
              response.isEmpty
                  ? const SizedBox()
                  : CaptionString(
                      caption: UtilFunctions.extractImageCaption(response),
                    ),
              const SizedBox(
                height: 10.0,
              ),
              isLoadingOutput
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : OutputImageGallery(outputImages: outputImages),
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
                      '',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                },
              ),
              IconButton(
                onPressed: handleLabelTapDebug,
                icon: const Icon(Icons.save),
              ),
            ],
          ),
        ));
  }
}

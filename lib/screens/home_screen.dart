import 'dart:io';
import 'dart:typed_data';
import 'package:dramatic_outputs/reusable/homescreen/caption_text.dart';
import 'package:dramatic_outputs/reusable/homescreen/image_picker_column.dart';
import 'package:dramatic_outputs/reusable/levelPicker/three_way_switch_lib.dart';
import 'package:dramatic_outputs/reusable/output/image_view.dart';
import 'package:dramatic_outputs/reusable/homescreen/home_screen_drawer.dart';
import 'package:dramatic_outputs/reusable/homescreen/label_picker.dart';
import 'package:dramatic_outputs/reusable/output/output_image_gallery.dart';
import 'package:dramatic_outputs/utils/api_functions.dart';
import 'package:dramatic_outputs/utils/random_image_request.dart';
import 'package:dramatic_outputs/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:dramatic_outputs/reusable/levelPicker/mode_toggle_button.dart';

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
  String currentLevel = "Medium";
  bool is300mmMode = false;
  bool isGenerating = false;
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
    if (isGenerating) {
      print("Label tap is not working");
      return;
    }
    print("Label tap is working");
    setState(
      () {
        debugPrint("Button pressed for index: $index");
        isGenerating = true;
        isLoadingOutput = true; // Show loading state
      },
    );

    try {
      // Call the API
      final apiService = ApiFunctions();
      final List<String> images = await apiService.selectLabel(
        filename: fileName,
        labelIndex: index,
        level: currentLevel,
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
    } finally {
      setState(() {
        isGenerating = false;
        isLoadingOutput = false; // Remove loading state on error
      });
    }
  }

  void handleLabelTapDebug() {
    setState(() {
      randomImageFuture = generateRandomImage();
    });
  }

  Future<void> refreshBackendUrl() async {
    await ApiFunctions.fetchBackendUrl();
    setState(() {}); // Update UI (optional)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Backend URL updated!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dramatic Outputs',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white60),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ), // Refresh Icon
              onPressed: refreshBackendUrl, // Call refresh function
              tooltip: "Refresh Backend URL",
            ),
          ],
        ),
        drawer: const HomeScreenDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AbsorbPointer(
                absorbing: isGenerating,
                child: ImagePickerColumn(
                  onCheckPressed: isGenerating
                      ? () {
                          print("Oncheck pressed is disabled");
                        }
                      : () {
                          print("Inside oncheck pressed");
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
                  onImageSelected: isGenerating
                      ? (File _) {} // No-op function to avoid type error
                      : (File image) {
                          if (selectedImage != null &&
                              selectedImage!.path == image.path) {
                            print("Image already selected, ignoring tap...");
                            return; // Prevent resetting if the same image is tapped
                          }
                          setState(() {
                            selectedImage = image;
                          });
                        },
                  onReset: isGenerating
                      ? () {}
                      : resetState, // Pass reset state callback
                ),
              ),
              isLoading == true
                  ? LinearProgressIndicator(
                      color: const Color.fromARGB(255, 47, 129, 100),
                      borderRadius: BorderRadius.circular(25),
                    )
                  : LabelPicker(
                      labelsWithIndices: extractedLabelsWithIndices,
                      onLabelTap: handleLabelTap, // Disable if generating,
                      currentFilename: filename,
                    ),
              const SizedBox(
                height: 5.0,
              ),
              IgnorePointer(
                ignoring: isGenerating,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ThreeWaySwitch(
                      onChanged: isGenerating
                          ? (value) {}
                          : (value) {
                              setState(() {
                                currentLevel = value;
                              });
                              print("Selected Level: $currentLevel");
                            },
                    ),
                    const SizedBox(width: 20.0),
                    ModeToggleButton(
                      onChanged: isGenerating
                          ? (value) {}
                          : (value) {
                              setState(() {
                                is300mmMode = value;
                              });
                              print("300mm Mode: $is300mmMode");
                            },
                    ),
                  ],
                ),
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
                  : OutputImageGallery(
                      outputImages: outputImages,
                      onReset: resetState,
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
                    return ImageView(
                      imagePath: image,
                      imageData: imageData,
                      onReset: resetState,
                    );
                  } else {
                    return const Text(
                      '',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                },
              ),
              // IconButton(
              //   onPressed: handleLabelTapDebug,
              //   icon: const Icon(Icons.save),
              // ),
            ],
          ),
        ));
  }
}

import 'package:dramatic_outputs/models/feedback_model.dart';
import 'package:dramatic_outputs/utils/device_id_manager.dart';
import 'package:dramatic_outputs/utils/util_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PopUpForm {
  static List<String> items = [
    "Looks unrealistic",
    "Misidentified areas",
    "Tampered with other parts of image",
    "Offensive image content",
  ];
  static final _formKey = GlobalKey<FormState>();
  static final _database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://dramatic-outputs-default-rtdb.asia-southeast1.firebasedatabase.app/");
  static final _feedbackRef = _database.ref("feedbacks");
  static final _feedbackCount = _database.ref("feedbackCount");
  static Set<String> selectedItems = {};
  static TextEditingController emailController = TextEditingController();
  static TextEditingController additionalCommentsController =
      TextEditingController();

  static void handleFormSubmission() async {
    String feedbackId = UtilFunctions.generateUniqueFeedbackId();
    String deviceId = await DeviceIdManager.getDeviceId();
    final String email = emailController.text;
    final List<String> selectedItemsList = selectedItems.toList();
    final String additionalComments = additionalCommentsController.text;
    final feedback = FeedbackModel(
      feedbackId: feedbackId,
      deviceId: deviceId,
      timestamp: DateTime.now().toString(),
      textFeedback: additionalComments,
      chipFeedback: selectedItemsList.join(", "),
      email: email,
      imagePrompt: "ImagePromptPlaceholder",
      imageUrls: ["ImageUrlsPlaceholder", "ImageUrlsPlaceholder"],
    );

    try {
      await _feedbackRef.child(feedbackId).set(feedback.toMap());
      print("Feedback submitted successfully");
    } catch (e) {
      print("Error: $e");
    }
  }

  static String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? "");
    if (!isEmailValid) {
      return "Please enter a valid email";
    }
    return null;
  }

  static void showFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Help us improve 🫶",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  TextFormField(
                    validator: validateEmail,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "abc@example.com",
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Selection Chips
                  const Text(
                    "Select all that apply:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Wrap(
                    spacing: 10.0,
                    children: items.map((item) {
                      final isSelected = selectedItems.contains(item);
                      return ChoiceChip(
                        label: Text(item),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          if (selected) {
                            selectedItems.add(item);
                          } else {
                            selectedItems.remove(item);
                          }
                          // Trigger a rebuild to show updated selection
                          (context as Element).markNeedsBuild();
                        },
                        selectedColor: Colors.blue.shade200,
                        backgroundColor: Colors.grey.shade300,
                        labelStyle: TextStyle(
                          color:
                              isSelected ? Colors.black : Colors.grey.shade600,
                        ),
                      );
                    }).toList(),
                  ),
                  if (selectedItems.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Please select at least one option.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: additionalCommentsController,
                    minLines: 2,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Additional comments...",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            // Cancel Button
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // Submit Button
            TextButton(
              child: const Text("Submit Feedback "),
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    selectedItems.isNotEmpty) {
                  handleFormSubmission();
                  Navigator.of(context).pop(); // Close the dialog
                } else if (selectedItems.isEmpty) {
                  (context as Element).markNeedsBuild();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class PopUpForm {
  static List<String> items = [
    "Looks unrealistic",
    "Misidentified areas",
    "Tampered with other parts of image",
    "Offensive image content",
  ];
  static Set<String> selectedItems = {};
  static TextEditingController emailController = TextEditingController();
  static TextEditingController additionalCommentsController =
      TextEditingController();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                TextField(
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
                        color: isSelected ? Colors.black : Colors.grey.shade600,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                TextField(
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
              child: const Text("Submit"),
              onPressed: () {
                // Retrieve values and handle form submission
                String email = emailController.text;

                // You can add validation or handle data here
                print("Email: $email");

                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

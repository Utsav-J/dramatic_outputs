import 'package:flutter/material.dart';

class LabelPicker extends StatelessWidget {
  const LabelPicker({super.key, required this.onLabelTap});

  final void Function() onLabelTap;
  final Map<String, dynamic> json_data = const {
    "labels": ["Sky", "Lake", "Trees", "Hills"]
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...json_data['labels'].map<Widget>((label) {
              return Container(
                margin: const EdgeInsets.only(right: 8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 47, 129, 100),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    // Define what happens when the button is pressed
                    onLabelTap();
                  },
                  child: Text(
                    label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.0),
                  ),
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}

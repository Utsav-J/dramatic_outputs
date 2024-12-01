import 'package:flutter/material.dart';

class LabelPicker extends StatelessWidget {
  const LabelPicker(
      {super.key, required this.onLabelTap, required this.labelsWithIndices});

  final void Function(int) onLabelTap;
  final Map<String, dynamic> json_data = const {
    "labels": ["Sky", "Lake", "Trees", "Hills"]
  };
  // final List<String> uniqueLabels;
  final Map<String, int> labelsWithIndices;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: labelsWithIndices.entries.map<Widget>((entry) {
              final label = entry.key;
              final index = entry.value;
              return Container(
                margin: const EdgeInsets.only(right: 8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 47, 129, 100),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    onLabelTap(index);
                  },
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

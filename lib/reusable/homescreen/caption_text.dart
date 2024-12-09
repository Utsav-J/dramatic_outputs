import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard

class CaptionString extends StatefulWidget {
  const CaptionString({super.key, required this.caption});
  final String caption;

  @override
  _CaptionStringState createState() => _CaptionStringState();
}

class _CaptionStringState extends State<CaptionString> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.caption));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Caption copied to clipboard!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: toggleExpansion,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: isExpanded ? 20.0 : 8.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white.withOpacity(0.09),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Caption",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      isExpanded
                          ? GestureDetector(
                              onTap: copyToClipboard,
                              child: const Icon(
                                Icons.copy_outlined,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(width: 15.0),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        turns: isExpanded ? 0.5 : 0.0, // Rotates by 180 degrees
                        child: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: Colors.white,
                        ),
                      ),

                      // Copy button
                    ],
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate,
                child: isExpanded
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.caption,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

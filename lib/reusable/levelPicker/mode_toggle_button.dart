import 'package:flutter/material.dart';

class ModeToggleButton extends StatefulWidget {
  final Function(bool) onChanged;
  final bool initialValue;

  const ModeToggleButton({
    super.key,
    required this.onChanged,
    this.initialValue = false,
  });

  @override
  ModeToggleButtonState createState() => ModeToggleButtonState();
}

class ModeToggleButtonState extends State<ModeToggleButton> {
  late bool is300mmMode;

  @override
  void initState() {
    super.initState();
    is300mmMode = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          is300mmMode = !is300mmMode;
        });
        widget.onChanged(is300mmMode);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: is300mmMode
              ? const Color.fromARGB(255, 198, 160, 232) // Active color
              : const Color.fromARGB(255, 192, 219, 250), // Inactive color
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: is300mmMode
                ? const Color.fromARGB(255, 123, 44, 191)
                : Colors.grey.shade400,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '300mm',
              style: TextStyle(
                color: is300mmMode ? Colors.black : Colors.black87,
                fontWeight: is300mmMode ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    is300mmMode ? Colors.purple.shade800 : Colors.grey.shade600,
              ),
              child: Icon(
                is300mmMode ? Icons.check : Icons.close,
                size: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

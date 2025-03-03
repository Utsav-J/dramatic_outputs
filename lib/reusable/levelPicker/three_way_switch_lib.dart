import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ThreeWaySwitch extends StatefulWidget {
  final Function(String) onChanged;

  const ThreeWaySwitch({super.key, required this.onChanged});

  @override
  ThreeWaySwitchState createState() => ThreeWaySwitchState();
}

class ThreeWaySwitchState extends State<ThreeWaySwitch> {
  int selectedIndex = 1; // Default to "Medium"

  final List<String> labels = ["Low", "Medium", "High"];
  final List<Color> colors = [
    // Color.fromARGB(255, 115, 194, 251),
    Color.fromARGB(255, 255, 225, 156),
    // Color.fromARGB(255, 0, 140, 118),
    Color.fromARGB(255, 153, 215, 200),
    // Color.fromARGB(255, 123, 44, 191),
    Color.fromARGB(255, 198, 160, 232),
  ];

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 80.0,
      minHeight: 40.0,
      cornerRadius: 10.0,
      activeBgColors: [
        [colors[0]], // Low
        [colors[1]], // Medium
        [colors[2]], // High
      ],
      activeFgColor: Colors.black,
      inactiveBgColor: Color.fromARGB(255, 192, 219, 250),
      inactiveFgColor: Colors.black,
      initialLabelIndex: selectedIndex,
      totalSwitches: 3,
      labels: labels,
      radiusStyle: true,
      animate: true,
      activeBorders: [
        Border.all(
          color: const Color.fromARGB(255, 255, 183, 0),
          width: 3.0,
        ),
        Border.all(
          color: const Color.fromARGB(255, 0, 140, 118),
          width: 3.0,
        ),
        Border.all(
          color: const Color.fromARGB(255, 123, 44, 191),
          width: 3.0,
        ),
      ],
      curve: Curves.fastLinearToSlowEaseIn,
      onToggle: (index) {
        if (index != null) {
          setState(() {
            selectedIndex = index;
          });
          widget.onChanged(labels[index]);
        }
      },
    );
  }
}

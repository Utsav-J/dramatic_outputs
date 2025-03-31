import 'package:flutter/material.dart';
import 'package:dramatic_outputs/reusable/levelPicker/three_way_switch_lib.dart';
import 'package:dramatic_outputs/reusable/levelPicker/mode_toggle_button.dart';

class ToggleSwitchesRow extends StatelessWidget {
  final Function(String) onLevelChanged;
  final Function(bool) onModeChanged;
  final bool isGenerating;

  const ToggleSwitchesRow({
    super.key,
    required this.onLevelChanged,
    required this.onModeChanged,
    required this.isGenerating,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isGenerating,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ThreeWaySwitch(
            onChanged: isGenerating
                ? (value) {}
                : (value) {
                    onLevelChanged(value);
                  },
          ),
          const SizedBox(width: 20.0),
          ModeToggleButton(
            onChanged: isGenerating
                ? (value) {}
                : (value) {
                    onModeChanged(value);
                  },
          ),
        ],
      ),
    );
  }
}

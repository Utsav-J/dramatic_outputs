import 'package:dramatic_outputs/reusable/pop_up_form.dart';
import 'package:dramatic_outputs/utils/device_id_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FeedbackButton extends StatefulWidget {
  const FeedbackButton({
    super.key,
    required this.isLike,
  });
  final bool isLike;

  @override
  State<FeedbackButton> createState() => _FeedbackButtonState();
}

class _FeedbackButtonState extends State<FeedbackButton> {
  static final _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        "https://dramatic-outputs-default-rtdb.asia-southeast1.firebasedatabase.app/",
  );
  static final _feedbackCount = _database.ref("feedbackCount");
  bool isActive = false;

  Future<void> handleFeedback(BuildContext context) async {
    final deviceId = await DeviceIdManager.getDeviceId();
    final feedbackRef = _feedbackCount.child(deviceId);

    // Paths for likes and dislikes
    final likesRef = feedbackRef.child("likes");
    final dislikesRef = feedbackRef.child("dislikes");

    if (widget.isLike) {
      // Handle Like button logic
      if (isActive) {
        // Already liked -> decrement likes
        await likesRef.set(ServerValue.increment(-1));
        setState(
          () {
            isActive = false; // Reset Like state
          },
        );
      } else {
        // Not liked -> increment likes
        await likesRef.set(ServerValue.increment(1));
        setState(
          () {
            isActive = true; // Set Like state
          },
        );

        // If the dislike button is active, reset it and decrement dislikes
        if (context.mounted &&
            context.findAncestorStateOfType<_FeedbackButtonState>()?.isActive ==
                false) {
          await dislikesRef.set(ServerValue.increment(-1));
          context.findAncestorStateOfType<_FeedbackButtonState>()?.setState(() {
            isActive = false; // Reset Dislike state
          });
        }
      }
    } else {
      // Handle Dislike button logic
      if (isActive) {
        // Already disliked -> decrement dislikes
        await dislikesRef.set(ServerValue.increment(-1));
        setState(() {
          isActive = false; // Reset Dislike state
        });
      } else {
        // Not disliked -> increment dislikes
        await dislikesRef.set(ServerValue.increment(1));
        setState(() {
          isActive = true; // Set Dislike state
        });

        // If the like button is active, reset it and decrement likes
        if (context.mounted &&
            context.findAncestorStateOfType<_FeedbackButtonState>()?.isActive ==
                false) {
          await likesRef.set(ServerValue.increment(-1));
          context.findAncestorStateOfType<_FeedbackButtonState>()?.setState(() {
            isActive = false; // Reset Like state
          });
        }
      }
      if (context.mounted && isActive) {
        PopUpForm.showFormDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleFeedback(context);
      },
      child: Row(
        children: [
          Icon(
            widget.isLike ? Icons.thumb_up : Icons.thumb_down,
            color: isActive
                ? (widget.isLike ? Colors.green : Colors.red)
                : Colors.grey,
          ),
          const SizedBox(width: 10.0),
          Text(
            isActive
                ? (widget.isLike ? "Liked" : "Disliked")
                : (widget.isLike ? "Like" : "Dislike"),
            style: TextStyle(
              color: isActive
                  ? (widget.isLike ? Colors.green : Colors.red)
                  : Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

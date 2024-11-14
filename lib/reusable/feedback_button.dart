import 'package:dramatic_outputs/reusable/pop_up_form.dart';
import 'package:flutter/material.dart';

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({
    super.key,
    required this.isLike,
  });
  final bool isLike;

  void handleLike() {
    // Define what happens when the button is pressed
    print("Good");
  }

  void handleDislike(BuildContext context) {
    PopUpForm.showFormDialog(context);
    // Define what happens when the button is pressed
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLike
          ? () {
              handleLike();
            }
          : () {
              handleDislike(context);
            },
      child: Row(
        children: [
          isLike
              ? const Icon(Icons.thumb_up_off_alt_sharp, color: Colors.green)
              : const Icon(Icons.thumb_down_sharp,
                  color: Color.fromARGB(255, 245, 145, 138)),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            isLike ? "Like" : "Dislike",
            style: TextStyle(
              color: isLike ? Colors.green : Color.fromARGB(255, 245, 145, 138),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

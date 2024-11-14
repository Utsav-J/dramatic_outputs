import 'package:flutter/foundation.dart' show immutable;

@immutable
class FeedbackModel {
  final String feedbackId; //auto-generated
  final String deviceId; //auto-generated
  final String timestamp; //auto-generated

  final String textFeedback; //user input
  final String chipFeedback; //user input
  final String email;

  final String imagePrompt; //system generated
  final List<String> imageUrls; //firebase storage urls

  const FeedbackModel({
    required this.feedbackId,
    required this.deviceId,
    required this.timestamp,
    required this.textFeedback,
    required this.chipFeedback,
    required this.email,
    required this.imagePrompt,
    required this.imageUrls,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> json) {
    return FeedbackModel(
      feedbackId: json['feedbackId'],
      deviceId: json['deviceId'],
      timestamp: json['timestamp'],
      textFeedback: json['textFeedback'],
      chipFeedback: json['chipFeedback'],
      email: json['email'],
      imagePrompt: json['imagePrompt'],
      imageUrls: json['imageUrls'].cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['feedbackId'] = feedbackId;
    data['deviceId'] = deviceId;
    data['timestamp'] = timestamp;
    data['textFeedback'] = textFeedback;
    data['chipFeedback'] = chipFeedback;
    data['email'] = email;
    data['imagePrompt'] = imagePrompt;
    data['imageUrls'] = imageUrls;
    return data;
  }
}

// {
//     "feedbackId": "unique_id",
//     "deviceId": "user_id",
//     "timestamp": "timestamp",
//     "textFeedback": "user_textFeedback_input",
//     "imagePrompt": "system_generated_textFeedback",
//     "imageUrls": [
//         "image1_url",
//         "image2_url"
//     ]
// }
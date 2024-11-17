import 'package:uuid/uuid.dart';

class UtilFunctions {
  static List<String> extractLabelsFromJson(Map<String, dynamic> jsonData) {
    print(jsonData);
    List<dynamic> dynamicLabels =
        jsonData['json_data']['<CAPTION_TO_PHRASE_GROUNDING>']['labels'];
    List<String> listOfLabels =
        dynamicLabels.map((label) => label.toString()).toList();
    // List<String> listOfLabels =
    //     jsonData['json_data']['<CAPTION_TO_PHRASE_GROUNDING>']['labels'];
    Set<String> uniqueLabels = Set.from(listOfLabels);
    // print(listOfLabels);
    // print(uniqueLabels);
    return uniqueLabels.toList();
  }

  static String extractImageCaption(Map<dynamic, dynamic> jsonData) {
    String imageCaption = jsonData['json_data']['<MORE_DETAILED_CAPTION>'];
    return imageCaption.toString();
  }

  static String generateUniqueFeedbackId() {
    var uuid = const Uuid();
    String feedbackId = uuid.v4();
    print(feedbackId);
    return feedbackId;
  }
}

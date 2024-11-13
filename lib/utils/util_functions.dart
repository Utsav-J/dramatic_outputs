class UtilFunctions {
  static List<String> extractLabelsFromJson(Map<String, dynamic> jsonData) {
    List<String> listOfLabels =
        jsonData['<CAPTION_TO_PHRASE_GROUNDING>']['labels'];
    Set<String> uniqueLabels = Set.from(listOfLabels);
    // print(listOfLabels);
    // print(uniqueLabels);
    return uniqueLabels.toList();
  }
}

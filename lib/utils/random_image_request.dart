import "dart:typed_data";

import "package:dio/dio.dart";
import "package:flutter/material.dart";

Future<Map<String, dynamic>> generateRandomImage() async {
  final dio = Dio();
  Map<String, dynamic> headers = {
    "X-Api-Key": "Wa6pVvpu1Ksii7DV/IBtTg==ZiYuLPawaED1HMo3",
    "Accept": "image/jpg"
  };
  try {
    final Response response = await dio.get(
      "https://api.api-ninjas.com/v1/randomimage?category=nature",
      options: Options(
        headers: headers,
        responseType: ResponseType.bytes,
      ),
    );
    // print("Here is the response data: ${response.data}");
    // print("\nend");
    return {
      "image": Image.memory(response.data),
      "data": response.data,
    };
  } catch (e) {
    print('Error: $e');
    return {
      "image": Image.asset("assets/images/image_placeholder.png"),
      "data": Uint8List(0),
    };
  }
}

import 'package:dramatic_outputs/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class StaticVariables {
  static List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: 'Welcome to Dramatic Outputs',
      description: 'Experience the power of AI to fulfil your imagical demands',
      image: 'assets/onboarding/welcome.png',
      bgColor: const Color.fromARGB(255, 87, 108, 225),
    ),
    OnboardingPageModel(
      title: 'Pick an Image',
      description: 'Choose any image from your gallery',
      image: 'assets/onboarding/pickanimage.png',
      bgColor: const Color(0xff1eb090),
    ),
    OnboardingPageModel(
      title: 'Select the effect you want',
      description:
          'Browse through our simple list of effect that aligns with your picture',
      image: 'assets/onboarding/optionChoose.png',
      bgColor: const Color.fromARGB(255, 243, 91, 57),
    ),
    OnboardingPageModel(
      title: 'Let AI do the rest',
      description: 'Wait for the AI to serve you with an eye catching result',
      image: 'assets/onboarding/ai_art.png',
      bgColor: Colors.purple,
    ),
  ];
}

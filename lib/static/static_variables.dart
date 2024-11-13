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

  static Map<String, dynamic> exampleJsonData = {
    "<CAPTION_TO_PHRASE_GROUNDING>": {
      "bboxes": [
        [
          412.79998779296875,
          4.372499942779541,
          1278.0799560546875,
          335.88751220703125
        ],
        [
          449.91998291015625,
          451.95751953125,
          845.4400024414062,
          793.8074951171875
        ],
        [
          452.47998046875,
          560.0775146484375,
          594.5599975585938,
          747.697509765625
        ],
        [
          732.7999877929688,
          567.2324829101562,
          841.5999755859375,
          758.0325317382812
        ],
        [
          453.7599792480469,
          560.8724975585938,
          547.2000122070312,
          746.9025268554688
        ],
        [
          599.6799926757812,
          514.7625122070312,
          670.0799560546875,
          602.2125244140625
        ],
        [
          709.760009765625,
          517.1475219726562,
          775.0399780273438,
          603.802490234375
        ],
        [752, 455.9324951171875, 789.1199951171875, 521.1224975585938],
        [
          676.47998046875,
          486.14251708984375,
          721.2799682617188,
          537.0225219726562
        ],
        [714.8800048828125, 463.88250732421875, 752, 518.7374877929688],
        [
          449.91998291015625,
          452.75250244140625,
          845.4400024414062,
          793.8074951171875
        ],
        [
          4.480000019073486,
          291.36749267578125,
          1278.0799560546875,
          389.1524963378906
        ],
        [474.239990234375, 609.3674926757812, 624, 793.8074951171875],
        [
          4.480000019073486,
          3.577500104904175,
          1278.0799560546875,
          335.0924987792969
        ],
        [
          4.480000019073486,
          378.8175048828125,
          1278.0799560546875,
          428.1075134277344
        ]
      ],
      "labels": [
        "Aurora Borealis",
        "Dogs",
        "Dogs",
        "Dogs",
        "Dogs",
        "Dogs",
        "Dogs",
        "Dogs",
        "Dogs",
        "Dogs",
        "Husky Dogs",
        "Mountains",
        "Ropes",
        "Sky",
        "Water"
      ]
    },
    "<MORE_DETAILED_CAPTION>":
        "The image shows a group of husky dogs pulling a sled through a snowy landscape. The sky is filled with a beautiful display of the Northern Lights, also known as Aurora Borealis, which is a phenomenon that occurs in the night sky. The aurora borealis is a bright green color, and it is visible in the top right corner of the image. The dogs are harnessed to the sled with ropes, and they are walking across the snow-covered ground. In the background, there are mountains and a body of water, and a few people can be seen in the distance. The image is taken from a low angle, looking up at the sky."
  };
}

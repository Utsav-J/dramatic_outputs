import 'package:dramatic_outputs/reusable/home_screen_drawer.dart';
import 'package:dramatic_outputs/reusable/image_picker_column.dart';
import 'package:dramatic_outputs/reusable/image_view.dart';
import 'package:dramatic_outputs/reusable/label_picker.dart';
import 'package:dramatic_outputs/utils/random_image_request.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Image>? randomImageFuture;
  void handleLabelTap() {
    setState(() {
      randomImageFuture = generateRandomImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dramatic Outputs',
            style: TextStyle(color: Colors.white),
          ),
          // backgroundColor: const Color.fromARGB(255, 68, 41, 113),
        ),
        drawer: const HomeScreenDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImagePickerColumn(),
              LabelPicker(
                onLabelTap: handleLabelTap,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              ),
              FutureBuilder<Image?>(
                future: randomImageFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Error loading image',
                      style: TextStyle(color: Colors.white),
                    );
                  } else if (snapshot.hasData) {
                    return ImageView(imagePath: snapshot.data!);
                  } else {
                    return const Text('Tap a label to generate an image',
                        style: TextStyle(color: Colors.white));
                  }
                },
              )
            ],
          ),
        ));
  }
}

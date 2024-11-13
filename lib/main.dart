import 'package:dramatic_outputs/firebase_options.dart';
import 'package:dramatic_outputs/routes/routes.dart';
import 'package:dramatic_outputs/screens/home_screen.dart';
import 'package:dramatic_outputs/screens/onboarding_screen.dart';
import 'package:dramatic_outputs/static/static_variables.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isOnboardingDone = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  isOnboardingDone = prefs.getBool('isOnboardingDone') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Dramatic Outputs",
          onGenerateRoute: Routes.onGenerateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme:
                const AppBarTheme(color: Color.fromRGBO(30, 55, 76, 1)),
            scaffoldBackgroundColor: Color.fromRGBO(23, 42, 58, 1),
          ),
          home: isOnboardingDone
              ? const HomeScreen()
              : OnboardingPage(
                  callback: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  pages: StaticVariables.pages,
                ),
        );
      },
    );
  }
}

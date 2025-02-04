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
import 'package:supabase_flutter/supabase_flutter.dart';

bool isOnboardingDone = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://gbkbgnpcuvdvoqjfsocb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdia2JnbnBjdXZkdm9xamZzb2NiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg2NTMyNzQsImV4cCI6MjA1NDIyOTI3NH0.v2u0NO8tjK1VP5Zw8E-hCuzD5k7C6335LsuvNgknbiA',
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
            scaffoldBackgroundColor: const Color.fromRGBO(23, 42, 58, 1),
          ),
          home: isOnboardingDone
              ? const HomeScreen()
              : OnboardingPage(
                  callback: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  pages: StaticVariables.pages,
                ),
        );
      },
    );
  }
}

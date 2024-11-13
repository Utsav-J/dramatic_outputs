import 'package:dramatic_outputs/screens/error_screen.dart';
import 'package:dramatic_outputs/screens/home_screen.dart';
import 'package:dramatic_outputs/screens/onboarding_screen.dart';
import 'package:dramatic_outputs/static/static_variables.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return _cupertinoRoute(const HomeScreen());
      case OnboardingPage.routeName:
        return _cupertinoRoute(OnboardingPage(pages: StaticVariables.pages));

      default:
        return _cupertinoRoute(
          ErrorScreen(
            error: 'Wrong Route provided ${settings.name}',
          ),
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
        builder: (_) => view,
      );
}

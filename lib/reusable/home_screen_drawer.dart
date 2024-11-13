import 'package:app_linkster/app_linkster.dart';
import 'package:dramatic_outputs/reusable/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({super.key});

  void openInstagramProfile() async {
    const String instagramUsername = 'acoolstick_';
    final Uri instagramWebUri =
        Uri.parse('https://www.instagram.com/$instagramUsername');

    final launcher = AppLinksterLauncher();
    await launcher.launchThisGuy(instagramWebUri.toString(),
        fallbackLaunchMode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: const Column(
              children: [
                Text(
                  'Developed by',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "Prism Team",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          MenuItem(
            icon: const Icon(Icons.person),
            title: "Utsav Jaiswal",
            onTap: openInstagramProfile,
          ),
          MenuItem(
            icon: const Icon(Icons.person),
            title: "Madan Raj Upadhyay",
            onTap: () {},
          ),
          MenuItem(
            icon: const Icon(Icons.person),
            title: "Ukasha Ahmed",
            onTap: () {},
          ),
          MenuItem(
            icon: const Icon(Icons.person),
            title: "Aditya Vikram Singh",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
